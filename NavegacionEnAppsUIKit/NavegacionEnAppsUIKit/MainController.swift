//
//  ViewController.swift
//  NavegacionEnAppsUIKit
//
//  Created by Rubén Segura Romo on 27/3/25.
//

import UIKit

class MainController: UIViewController {
	
	let paramSegue = "Soy el parámetro"

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "vistaConParam" {
			let destino = segue.destination as? ParamViewController
			destino?.paramSegue = paramSegue
		}
			
	}


}

