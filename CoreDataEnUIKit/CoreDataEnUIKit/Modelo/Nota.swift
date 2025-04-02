//
//  Nota.swift
//  CoreDataEnUIKit
//
//  Created by Rubén Segura Romo on 1/4/25.
//

import Foundation
import CoreData
import UIKit

struct NotaModel {
	let titulo: String
	let descripcion: String
	let fecha: Date
}

@MainActor
final class Nota {
	
	public static let shared = Nota()
	
	func contexto() -> NSManagedObjectContext {
		let delegate = UIApplication.shared.delegate as! AppDelegate
		return delegate.persistentContainer.viewContext
	}
	
	func guardar(_ nota: NotaModel) {
		let contexto = contexto()
		let entityNotas = NSEntityDescription.insertNewObject(forEntityName: "Notas", into: contexto) as! Notas
		entityNotas.titulo = nota.titulo
		entityNotas.descripcion = nota.descripcion
		entityNotas.fecha = nota.fecha
		
		do {
			try contexto.save()
			print("Nota guardada")
		} catch let error as NSError {
			print("No se pudo guardar la nota: \(error), \(error.userInfo)")
		}
	}
	
	
	func editar(_ nota: NotaModel, _ notaEditar: Notas) {
		let contexto = contexto()
		notaEditar.setValue(nota.titulo, forKey: "titulo")
		notaEditar.setValue(nota.descripcion, forKey: "descripcion")
		notaEditar.setValue(nota.fecha, forKey: "fecha")
		
		do {
			try contexto.save()
			print("Nota editada")
		} catch let error as NSError {
			print("No se pudo editar la nota: \(error), \(error.userInfo)")
		}
	}
}
