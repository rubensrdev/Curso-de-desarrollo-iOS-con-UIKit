//
//  OnboardingContentViewController.swift
//  OnBoardViewEnUIKit
//
//  Created by Rubén Segura Romo on 8/4/25.
//

import UIKit

/// Vista controladora que representa una única pantalla del onboarding.
/// Esta clase es reutilizada para las distintas páginas, recibiendo contenido dinámico desde el `PageViewController`.
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
		// Se asignan los valores pasados desde el PageViewController
		imagenView.image = UIImage(named: imagen ?? "")
		tituloLabel.text = titulo
		descripcionLabel.text = descripcion
    }

	/// Acción que finaliza el onboarding y marca en UserDefaults que ya ha sido completado.
	/// Desde aquí se debe redirigir a la pantalla principal de la aplicación.
	@IBAction func finalizarOnBoarding(_ sender: Any) {
		UserDefaults.standard.set(true, forKey: "onBoardingCompletado")
		// TODO: Ir a la vista principal
	}
	
}
