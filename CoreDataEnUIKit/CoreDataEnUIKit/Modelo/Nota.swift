//
//  Nota.swift
//  CoreDataEnUIKit
//
//  Created by Rubén Segura Romo on 1/4/25.
//

import Foundation
import CoreData
import UIKit

/// Modelo base utilizado para representar una nota fuera del contexto de Core Data.
/// Se usa como estructura puente entre la lógica de la app y la capa de persistencia.
struct NotaModel {
	/// Título de la nota.
	let titulo: String
	/// Descripción o cuerpo de la nota.
	let descripcion: String
	/// Fecha asociada a la nota (creación o edición).
	let fecha: Date
}

/// Clase singleton que centraliza el acceso a Core Data para crear y editar notas.
/// Maneja el contexto, inserciones y modificaciones sobre la entidad `Notas`.
@MainActor
final class Nota {
	
	/// Instancia compartida para acceder a las funciones de persistencia.
	public static let shared = Nota()
	
	/// Devuelve el contexto de Core Data desde el `AppDelegate`.
	/// - Usado como punto de acceso para realizar operaciones CRUD.
	func contexto() -> NSManagedObjectContext {
		let delegate = UIApplication.shared.delegate as! AppDelegate
		return delegate.persistentContainer.viewContext
	}
	
	/// Guarda una nueva nota en Core Data utilizando los datos del modelo.
	/// - Parameter nota: Instancia de `NotaModel` con los datos a persistir.
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
	
	/// Edita una nota existente en Core Data con nuevos valores.
	/// - Parameters:
	///   - nota: Modelo actualizado con los nuevos datos.
	///   - notaEditar: Objeto `Notas` de Core Data a modificar.
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
