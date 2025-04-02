//
//  HomeViewController.swift
//  CoreDataEnUIKit
//
//  Created by Rubén Segura Romo on 1/4/25.
//

import UIKit
import CoreData

@MainActor
final class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, @preconcurrency NSFetchedResultsControllerDelegate {
	
	@IBOutlet weak var tablaNotasListadas: UITableView!
	var notas: [Notas] = []
	var fetchResultController: NSFetchedResultsController<Notas>!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		tablaNotasListadas.delegate = self
		tablaNotasListadas.dataSource = self
		obtenerNotas()
    }
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		notas.count
	}
	
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
			print( "Editar nota")
		}
		editar.image = UIImage(systemName: "pencil")
		return UISwipeActionsConfiguration(actions: [eliminar, editar])
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "editarNotaSegue", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "editarNotaSegue" {
			if let id = tablaNotasListadas.indexPathForSelectedRow {
				let fila = notas[id.row]
				let destino = segue.destination as? AddViewController
				destino?.notaEditar = fila
			}
		}
	}
	
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
	
	func controllerWillChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
		tablaNotasListadas.beginUpdates()
	}
	
	func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
		tablaNotasListadas.endUpdates()
	}
	
	func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
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
