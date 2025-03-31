//
//  ViewController.swift
//  Ejercicio1-TODO-App
//
//  Created by Rubén Segura Romo on 31/3/25.
//

import UIKit

class MainController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var tareasTableView: UITableView!
	
	var tareas: [Tarea] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		tareasTableView.delegate = self
		tareasTableView.dataSource = self
		inicializarConDatosDePrueba()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		tareas.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let celda = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
		let item = tareas[indexPath.row]
		celda.textLabel?.text = item.titulo
		return celda
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "segueTareaDetalle" {
			if let indexPath = tareasTableView.indexPathForSelectedRow {
				let fila = tareas[indexPath.row]
				let destino = segue.destination as! DetalleTareaViewController
				destino.tarea = fila
			}
		}
		if segue.identifier == "segueNuevaTarea",
		   let destino = segue.destination.presentationController as? UISheetPresentationController {
			destino.detents = [.medium()]
			destino.prefersGrabberVisible = true
		}
	}
	
	/// Inicializa la lista de tareas con datos de prueba
	func inicializarConDatosDePrueba() {
		tareas.append(
			Tarea(id: UUID(),
				  titulo: "Estudiar",
				  descripcion: "Tienes que estudiar para el examen de inglés",
				  fechaCreacion: Date(),
				  estaCompletada: false)
		)
		tareas.append(
			Tarea(id: UUID(),
				  titulo: "Ir a la compra",
				  descripcion: "Manzanas, ensaladas, huevos, verduras",
				  fechaCreacion: Date(),
				  estaCompletada: false)
		)
		tareas.append(
			Tarea(id: UUID(),
				  titulo: "Hacer una app de TODOs",
				  descripcion: "Practicar lo aprendido para hacer una app de TODOs con UI Kit",
				  fechaCreacion: Date(),
				  estaCompletada: true)
		)
	}

}

