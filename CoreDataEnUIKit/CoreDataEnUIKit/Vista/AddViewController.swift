//
//  AddViewController.swift
//  CoreDataEnUIKit
//
//  Created by Rubén Segura Romo on 1/4/25.
//

import UIKit

class AddViewController: UIViewController {

	@IBOutlet weak var tituloTextfield: UITextField!
	@IBOutlet weak var notaTextview: UITextView!
	@IBOutlet weak var fechaDatePicker: UIDatePicker!
	
	var notaEditar: Notas?
	
	override func viewDidLoad() {
        super.viewDidLoad()

		self.title = notaEditar == nil ? "Nueva nota" : "Editar nota"
		tituloTextfield.text = notaEditar?.titulo
		notaTextview.text = notaEditar?.descripcion
		fechaDatePicker.date = notaEditar?.fecha ?? Date()
    }

	@IBAction func guardar(_ sender: Any) {
		if notaEditar != nil {
			if let titulo = tituloTextfield.text, !titulo.isEmpty,
			   let descripcion = notaTextview.text, !descripcion.isEmpty {
				let nota = NotaModel(titulo: titulo, descripcion: descripcion, fecha: fechaDatePicker.date)
				Nota.shared.editar(nota, notaEditar!)
				navigationController?.popViewController(animated: true)
			} else {
				alertarValidacion()
			}
		} else {
			if let titulo = tituloTextfield.text, !titulo.isEmpty,
			   let descripcion = notaTextview.text, !descripcion.isEmpty {
				let nota = NotaModel(titulo: titulo, descripcion: descripcion, fecha: fechaDatePicker.date)
				Nota.shared.guardar(nota)
				navigationController?.popViewController(animated: true)
			} else {
				alertarValidacion()
			}
		}
	}
	
	func alertarValidacion() {
		let alertController = UIAlertController(title: "Error", message: "Debes rellenar todos los campos", preferredStyle: .alert)
		let alertAction = UIAlertAction(title: "OK", style: .default)
		alertController.addAction(alertAction)
		present(alertController, animated: true)
	}
	
}
