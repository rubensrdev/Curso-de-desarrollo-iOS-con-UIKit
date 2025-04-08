//
//  ViewController.swift
//  Ejercicio3-JSONconAsyncAwait
//
//  Created by Rubén Segura Romo on 8/4/25.
//

import UIKit

class MainController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self
		tableView.delegate = self
		Task {
			do {
				try await PersonajeViewModel.shared.fetchPersonajes()
				tableView.reloadData()
			} catch {
				print("❌ Error al cargar los personajes: \(error.localizedDescription)")
			}
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		PersonajeViewModel.shared.personajes.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let personaje = PersonajeViewModel.shared.personajes[indexPath.row]
		let celda = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! CeldaTabla
		cargarDatosEnLaCelda(celda, personaje)
		return celda
	}
	
	fileprivate func cargarDatosEnLaCelda(_ celda: CeldaTabla, _ personaje: Personaje) {
		celda.nombreLabel.text = personaje.name
		if let url = URL(string: personaje.image) {
			Task {
				do {
					let (data, _) = try await URLSession.shared.data(from: url)
					if let image = UIImage(data: data) {
						celda.imagenView.image = image
					}
				} catch {
					print("❌ Error cargando imagen en la celda: \(error.localizedDescription)")
				}
			}
		}
	}
	
}

final class CeldaTabla: UITableViewCell {
	
	@IBOutlet weak var imagenView: UIImageView!
	@IBOutlet weak var nombreLabel: UILabel!
	
}

@MainActor
final class PersonajeViewModel {
	static let shared = PersonajeViewModel()
	var personajes: [Personaje] = []
	
	func fetchPersonajes() async throws {
		let url = URL(string: "https://rickandmortyapi.com/api/character")!
		let (data, _) = try await URLSession.shared.data(from: url)
		let rickAndMortyResult = try JSONDecoder().decode(RickAndMortyResult.self, from: data)
		personajes = rickAndMortyResult.results
	}
}

struct RickAndMortyResult: Codable, Sendable {
	let results: [Personaje]
}

struct Personaje: Codable, Sendable {
	let name: String
	let image: String
}
