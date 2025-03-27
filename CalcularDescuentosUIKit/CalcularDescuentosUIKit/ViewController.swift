//
//  ViewController.swift
//  CalcularDescuentosUIKit
//
//  Created by Rubén Segura Romo on 27/3/25.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var descuentoLabel: UILabel!
	@IBOutlet weak var precioFinalLabel: UILabel!
	
	@IBOutlet weak var porcentajeDescuentoTextField: UITextField!
	@IBOutlet weak var precioOriginalTextField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
	}

	@IBAction func calcularDescuento(_ sender: Any) {
		guard let porcentajeDescuento = Double(porcentajeDescuentoTextField.text ?? ""),
			  let precioDescuento = Double(precioOriginalTextField.text ?? "") else { return }
		
		let descuentoCalculado = precioDescuento * porcentajeDescuento / 100
		let precioFinal = precioDescuento - descuentoCalculado
		
		descuentoLabel.text = "\(descuentoCalculado) €"
		precioFinalLabel.text = "\(precioFinal) €"
	}
	
	@IBAction func limpiarCampos(_ sender: Any) {
		descuentoLabel.text = ""
		precioFinalLabel.text = ""
	}
	
}
