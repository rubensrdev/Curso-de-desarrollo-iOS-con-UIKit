//
//  CellDetailViewController.swift
//  TablasEnUIKit
//
//  Created by Rubén Segura Romo on 28/3/25.
//

import UIKit

class CellDetailViewController: UIViewController {
	
	
	@IBOutlet weak var nombreLabel: UILabel!
	@IBOutlet weak var telefonoLabel: UILabel!
	
	var contacto: Contacto?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		nombreLabel.text = contacto?.nombre
		telefonoLabel.text = contacto?.telefono
    }
    

}
