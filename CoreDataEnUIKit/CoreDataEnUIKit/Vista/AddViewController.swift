//
//  AddViewController.swift
//  CoreDataEnUIKit
//
//  Created by Rubén Segura Romo on 1/4/25.
//

import UIKit

/// Controlador que permite crear una nueva nota o editar una nota existente usando Core Data.
/// Contiene validación de campos y control de persistencia a través de un modelo intermedio (`NotaModel`).
class AddViewController: UIViewController {

	/// Campo de texto donde se introduce el título de la nota.
	@IBOutlet weak var tituloTextfield: UITextField!
	
	/// Área de texto donde se introduce la descripción o contenido de la nota.
	@IBOutlet weak var notaTextview: UITextView!
	
	/// Selector de fecha para elegir cuándo se creó o editó la nota.
	@IBOutlet weak var fechaDatePicker: UIDatePicker!
	
	/// Variable que contiene la nota a editar, si existe. Si es `nil`, se está creando una nueva nota.
	var notaEditar: Notas?
	
	/// Método que se ejecuta al cargar la vista. Si se trata de una edición, carga los datos previos en los campos.
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.title = notaEditar == nil ? "Nueva nota" : "Editar nota"
		tituloTextfield.text = notaEditar?.titulo
		notaTextview.text = notaEditar?.descripcion
		fechaDatePicker.date = notaEditar?.fecha ?? Date()
	}

	/// Acción vinculada al botón de guardar.
	/// - Si se está editando una nota, se actualizan sus valores.
	/// - Si se trata de una nueva nota, se guarda con los datos actuales.
	/// - Si algún campo está vacío, se muestra una alerta de validación.
	@IBAction func guardar(_ sender: Any) {
		if notaEditar != nil {
			if let titulo = tituloTextfield.text, !titulo.isEmpty,
			   let descripcion = notaTextview.text, !descripcion.isEmpty {
				
				let nota = NotaModel(titulo: titulo,
									 descripcion: descripcion,
									 fecha: fechaDatePicker.date)
				
				Nota.shared.editar(nota, notaEditar!)
				navigationController?.popViewController(animated: true)
			} else {
				alertarValidacion()
			}
		} else {
			if let titulo = tituloTextfield.text, !titulo.isEmpty,
			   let descripcion = notaTextview.text, !descripcion.isEmpty {
				
				let nota = NotaModel(titulo: titulo,
									 descripcion: descripcion,
									 fecha: fechaDatePicker.date)
				
				Nota.shared.guardar(nota)
				navigationController?.popViewController(animated: true)
			} else {
				alertarValidacion()
			}
		}
	}
	
	/// Muestra una alerta si los campos obligatorios no han sido rellenados.
	/// - Utilizada para validar el formulario antes de guardar o editar.
	func alertarValidacion() {
		let alertController = UIAlertController(
			title: "Error",
			message: "Debes rellenar todos los campos",
			preferredStyle: .alert
		)
		let alertAction = UIAlertAction(title: "OK", style: .default)
		alertController.addAction(alertAction)
		present(alertController, animated: true)
	}
}
