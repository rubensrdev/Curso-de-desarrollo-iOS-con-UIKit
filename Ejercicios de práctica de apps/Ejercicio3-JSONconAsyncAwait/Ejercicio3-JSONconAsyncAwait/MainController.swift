//
//  ViewController.swift
//  Ejercicio3-JSONconAsyncAwait
//
//  Created by Rubén Segura Romo on 8/4/25.
//

import UIKit

/// Controlador principal de la vista que muestra una lista de personajes obtenidos de una API.
/// Utiliza `UITableView` con un ViewModel que implementa patrón singleton y `async/await` para consumir datos.
class MainController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	/// Referencia a la tabla definida en Storyboard.
	@IBOutlet weak var tableView: UITableView!
	
	/// Método que se ejecuta cuando la vista se ha cargado.
	/// Se configuran los delegados y se inicia la carga de datos con `async/await`.
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self
		tableView.delegate = self

		// Iniciamos la llamada asincrónica al ViewModel para obtener los personajes
		Task {
			do {
				try await PersonajeViewModel.shared.fetchPersonajes()
				tableView.reloadData()
			} catch {
				print("❌ Error al cargar los personajes: \(error.localizedDescription)")
			}
		}
	}

	/// Devuelve el número de filas en la sección.
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		PersonajeViewModel.shared.personajes.count
	}

	/// Devuelve una celda configurada con los datos del personaje en el índice correspondiente.
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let personaje = PersonajeViewModel.shared.personajes[indexPath.row]
		let celda = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! CeldaTabla
		cargarDatosEnLaCelda(celda, personaje)
		return celda
	}

	/// Carga el contenido textual y la imagen de un personaje en una celda.
	/// La imagen se descarga de forma asincrónica.
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

/// Celda personalizada de la tabla que muestra el nombre e imagen del personaje.
final class CeldaTabla: UITableViewCell {
	@IBOutlet weak var imagenView: UIImageView!
	@IBOutlet weak var nombreLabel: UILabel!
}

/// ViewModel singleton que se encarga de obtener y almacenar la lista de personajes.
/// Está anotado con `@MainActor` para asegurar que sus operaciones modifican el estado en el hilo principal.
@MainActor
final class PersonajeViewModel {
	static let shared = PersonajeViewModel()
	var personajes: [Personaje] = []
	
	/// Método asincrónico que obtiene los personajes desde la API pública de Rick & Morty.
	/// Decodifica los datos utilizando `Codable`.
	func fetchPersonajes() async throws {
		let url = URL(string: "https://rickandmortyapi.com/api/character")!
		let (data, _) = try await URLSession.shared.data(from: url)
		let rickAndMortyResult = try JSONDecoder().decode(RickAndMortyResult.self, from: data)
		personajes = rickAndMortyResult.results
	}
}

/// Modelo del resultado principal que contiene la lista de personajes.
/// Utiliza `Codable` para deserialización automática y `Sendable` por buenas prácticas de concurrencia.
struct RickAndMortyResult: Codable, Sendable {
	let results: [Personaje]
}

/// Modelo de personaje con los campos que nos interesan: nombre e imagen.
struct Personaje: Codable, Sendable {
	let name: String
	let image: String
}
