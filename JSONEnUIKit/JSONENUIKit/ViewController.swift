//
//  ViewController.swift
//  JSONENUIKit
//
//  Created by Rubén Segura Romo on 2/4/25.
//

import UIKit

final class Celda: UITableViewCell {
	@IBOutlet weak var nombreLabel: UILabel!
	@IBOutlet weak var emailLabel: UILabel!
	@IBOutlet weak var imagenView: UIImageView!
}

final class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	@IBOutlet weak var tabla: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tabla.delegate = self
		tabla.dataSource = self
		ModeloViewModel.shared.fetch{ done in
			if done {
				self.tabla.reloadData()
			}
		}
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		ModeloViewModel.shared.datosModelo.data.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let celda = tabla.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! Celda
		let usuario = ModeloViewModel.shared.datosModelo.data[indexPath.row]
		celda.nombreLabel.text = usuario.first_name
		celda.emailLabel.text = usuario.email
		guard let imageURL = URL(string: usuario.avatar) else { fatalError("sin imagen") }
		DispatchQueue.global().async {
			guard let imageData = try? Data(contentsOf: imageURL) else { return }
			let image = UIImage(data: imageData)
			DispatchQueue.main.async {
				celda.imagenView.image = image
				self.tabla.reloadData()
			}
		}
		
		return celda
	}
	
}

