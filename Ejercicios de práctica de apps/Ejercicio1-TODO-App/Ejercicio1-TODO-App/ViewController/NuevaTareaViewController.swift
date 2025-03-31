//
//  NuevaTareaViewController.swift
//  Ejercicio1-TODO-App
//
//  Created by Rubén Segura Romo on 31/3/25.
//

import UIKit

class NuevaTareaViewController: UIViewController {

	@IBOutlet weak var tituloTextfield: UITextField!
	@IBOutlet weak var descripcionTextfiel: UITextField!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
	@IBAction func guardar(_ sender: Any) {
		let titulo = tituloTextfield.text ?? ""
		let descripcion = descripcionTextfiel.text ?? ""
		let tarea = Tarea(id: UUID(), titulo: titulo, descripcion: descripcion, fechaCreacion: Date(), estaCompletada: false)
		// TODO: Guardar la tarea en la lista de tareas del MainController
	}
	
}
