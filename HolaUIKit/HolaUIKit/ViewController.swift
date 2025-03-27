//
//  ViewController.swift
//  HolaUIKit
//
//  Created by Rubén Segura Romo on 26/3/25.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	@IBAction func toogleAlert(_ sender: UIButton) {
		let alert = UIAlertController(title: "Alerta", message: "Estamos dando los primeros pasos con UI Kit", preferredStyle: .alert)
		let ok = UIAlertAction(title: "Vale", style: .default) { _ in
			print("Pulsaste vale")
		}
		alert.addAction(ok)
		present(alert, animated: true) {
			print("Alerta presentada")
		}
	}
	
}

