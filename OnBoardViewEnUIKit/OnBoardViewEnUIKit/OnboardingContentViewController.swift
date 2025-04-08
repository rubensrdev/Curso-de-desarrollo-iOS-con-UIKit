//
//  OnboardingContentViewController.swift
//  OnBoardViewEnUIKit
//
//  Created by Rubén Segura Romo on 8/4/25.
//

import UIKit

class OnboardingContentViewController: UIViewController {

	@IBOutlet weak var imagenView: UIImageView!
	@IBOutlet weak var tituloLabel: UILabel!
	@IBOutlet weak var descripcionLabel: UILabel!
	
	var imagen: String?
	var titulo: String?
	var descripcion: String?
	var esUltimaPagina = false
	
	override func viewDidLoad() {
        super.viewDidLoad()
		imagenView.image = UIImage(named: imagen ?? "")
		tituloLabel.text = titulo
		descripcionLabel.text = descripcion
    }

	@IBAction func finalizarOnBoarding(_ sender: Any) {
		UserDefaults.standard.set(true, forKey: "onBoardingCompletado")
		// TODO: Ir a la vista principal
	}
	
}
