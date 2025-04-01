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
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

	@IBAction func guardar(_ sender: Any) {
		if let titulo = tituloTextfield.text, !titulo.isEmpty,
		   let descripcion = notaTextview.text, !descripcion.isEmpty {
			let nota = NotaModel(titulo: titulo, descripcion: descripcion, fecha: fechaDatePicker.date)
			Nota.shared.guardar(nota)
		}
		
	}
	
}
