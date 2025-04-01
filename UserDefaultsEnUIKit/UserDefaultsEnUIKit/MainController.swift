//
//  ViewController.swift
//  UserDefaultsEnUIKit
//
//  Created by Rubén Segura Romo on 1/4/25.
//

import UIKit

struct Datos: Codable {
	let nombre: String
	let apellidos: String
	let email: String
}

class MainController: UIViewController {
	
	@IBOutlet weak var nombreTextfield: UITextField!
	@IBOutlet weak var apellidosTextfield: UITextField!
	@IBOutlet weak var emailTextfield: UITextField!
	@IBOutlet weak var datosLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		actualizarDatosLabel()
	}
	
	func alertValidacionTodosLosCampos() {
		let alert = UIAlertController(title: "Error", message: "Todos los campos son obligatorios", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
		present(alert, animated: true)
	}
	
	func actualizarDatosLabel() {
		if let datosGuardadosCodificados = UserDefaults.standard.data(forKey: "datos"),
		   let datosGuardados = try? JSONDecoder().decode(Datos.self, from: datosGuardadosCodificados) {
			datosLabel.text = "Nombre: \(datosGuardados.nombre)\nApellidos: \(datosGuardados.apellidos)\nEmail: \(datosGuardados.email)"
			datosLabel.font = .preferredFont(forTextStyle: .headline)
			datosLabel.textColor = .label
		} else {
			datosLabel.text = "No hay datos guardados"
			datosLabel.font = .preferredFont(forTextStyle: .headline)
			datosLabel.textColor = .secondaryLabel
		}
	}

	@IBAction func guardar(_ sender: Any) {
		if nombreTextfield.text == "" || apellidosTextfield.text == "" || emailTextfield.text == "" {
			alertValidacionTodosLosCampos()
		} else {
			let datos = Datos(nombre: nombreTextfield.text!,
							  apellidos: apellidosTextfield.text!,
							  email: emailTextfield.text!)
			if let datosCodificados = try? JSONEncoder().encode(datos) {
				UserDefaults.standard.set(datosCodificados, forKey: "datos")
				actualizarDatosLabel()
			}
		}
	}
	
	@IBAction func resetear(_ sender: Any) {
		UserDefaults.standard.removeObject(forKey: "datos")
		actualizarDatosLabel()
	}
	
}

