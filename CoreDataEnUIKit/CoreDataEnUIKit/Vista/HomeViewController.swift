//
//  HomeViewController.swift
//  CoreDataEnUIKit
//
//  Created by Rubén Segura Romo on 1/4/25.
//

import UIKit
import CoreData

/// Controlador que muestra una lista de notas almacenadas en Core Data, gestionadas con `NSFetchedResultsController`.
/// Permite visualizar, eliminar y preparar la edición de notas en una tabla.
@MainActor
final class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, @preconcurrency NSFetchedResultsControllerDelegate {
	
	/// Tabla que muestra la lista de notas.
	@IBOutlet weak var tablaNotasListadas: UITableView!
	
	/// Array de notas cargadas desde Core Data.
	var notas: [Notas] = []
	
	/// Controlador de resultados que gestiona los cambios en Core Data y actualiza automáticamente la tabla.
	var fetchResultController: NSFetchedResultsController<Notas>!
	
	/// Método llamado al cargar la vista. Asigna delegados y lanza la carga inicial de datos.
	override func viewDidLoad() {
		super.viewDidLoad()
		tablaNotasListadas.delegate = self
		tablaNotasListadas.dataSource = self
		obtenerNotas()
	}
	
	/// Devuelve el número de filas en la tabla (una por cada nota).
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		notas.count
	}
	
	/// Configura y devuelve una celda para una nota en la posición indicada.
	/// - Muestra el título y la fecha formateada de la nota.
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let celda = tablaNotasListadas.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
		let nota = notas[indexPath.row]
		celda.textLabel?.text = nota.titulo
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .short
		dateFormatter.timeStyle = .short
		dateFormatter.locale = Locale.current
		celda.detailTextLabel?.text = dateFormatter.string(from: nota.fecha!)
		
		return celda
	}
	
	/// Configura las acciones disponibles al deslizar una celda hacia la izquierda.
	/// Incluye eliminar (elimina la nota de Core Data) y editar (placeholder).
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let eliminar = UIContextualAction(style: .destructive, title: "Eliminar") { (_, _, _) in
			let contexto = Nota.shared.contexto()
			let nota = self.fetchResultController.object(at: indexPath)
			contexto.delete(nota)
			do {
				try contexto.save()
			} catch let error as NSError {
				print("Error eliminando nota", error)
			}
		}
		eliminar.image = UIImage(systemName: "trash")
		
		let editar = UIContextualAction(style: .normal, title: "Editar") { (_, _, _) in
			print("Editar nota")
		}
		editar.image = UIImage(systemName: "pencil")
		
		return UISwipeActionsConfiguration(actions: [eliminar, editar])
	}
	
	/// Detecta la selección de una celda y lanza el segue hacia la vista de edición.
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "editarNotaSegue", sender: self)
	}
	
	/// Prepara la transición al controlador de edición pasando la nota seleccionada.
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "editarNotaSegue" {
			if let id = tablaNotasListadas.indexPathForSelectedRow {
				let fila = notas[id.row]
				let destino = segue.destination as? AddViewController
				destino?.notaEditar = fila
			}
		}
	}
	
	/// Realiza la consulta a Core Data para obtener todas las notas ordenadas por título.
	/// Inicializa y configura el `NSFetchedResultsController` para detectar cambios en tiempo real.
	func obtenerNotas() {
		let contexto = Nota.shared.contexto()
		let fetchRequest = Notas.fetchRequest()
		let order = NSSortDescriptor(key: "titulo", ascending: true)
		fetchRequest.sortDescriptors = [order]
		
		fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest,
														   managedObjectContext: contexto,
														   sectionNameKeyPath: nil,
														   cacheName: nil)
		fetchResultController.delegate = self
		
		do {
			try fetchResultController.performFetch()
			notas = fetchResultController.fetchedObjects!
		} catch let error as NSError {
			print("Error obteniendo las notas: \(error.localizedDescription)")
		}
	}
	
	/// Informa al `UITableView` de que comenzarán actualizaciones (insertar, eliminar, modificar filas).
	func controllerWillChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
		tablaNotasListadas.beginUpdates()
	}
	
	/// Informa al `UITableView` de que finalizaron las actualizaciones.
	func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
		tablaNotasListadas.endUpdates()
	}
	
	/// Se llama automáticamente cuando hay cambios en los objetos de Core Data.
	/// Actualiza la tabla de forma animada según el tipo de cambio: inserción, eliminación o actualización.
	func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
					didChange anObject: Any,
					at indexPath: IndexPath?,
					for type: NSFetchedResultsChangeType,
					newIndexPath: IndexPath?) {
		
		switch type {
		case .insert:
			self.tablaNotasListadas.insertRows(at: [newIndexPath!], with: .fade)
		case .delete:
			self.tablaNotasListadas.deleteRows(at: [indexPath!], with: .fade)
		case .update:
			self.tablaNotasListadas.reloadRows(at: [indexPath!], with: .fade)
		default:
			self.tablaNotasListadas.reloadData()
		}
		
		self.notas = controller.fetchedObjects as! [Notas]
	}
}
