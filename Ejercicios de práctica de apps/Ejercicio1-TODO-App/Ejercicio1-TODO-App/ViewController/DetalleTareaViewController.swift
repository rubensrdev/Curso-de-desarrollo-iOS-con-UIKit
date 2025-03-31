//
//  DetalleTareaViewController.swift
//  Ejercicio1-TODO-App
//
//  Created by Rubén Segura Romo on 31/3/25.
//

import UIKit

class DetalleTareaViewController: UIViewController {

	@IBOutlet weak var tituloLabel: UILabel!
	@IBOutlet weak var descripcionLabel: UILabel!
	@IBOutlet weak var fechaLabel: UILabel!
	@IBOutlet weak var estadoLabel: UILabel!
	
	var tarea: Tarea?
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		if let tarea = tarea {
			tituloLabel.text = tarea.titulo
			descripcionLabel.text = tarea.descripcion
			fechaLabel.text = tarea.fechaCreacion.description
			estadoLabel.text = tarea.estaCompletada ? "Completada" : "Pendiente"
			
			descripcionLabel.numberOfLines = 3
			estadoLabel.textColor = tarea.estaCompletada ? .systemGreen : .systemRed
		}
    }

}
