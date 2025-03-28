//
//  SheetViewController.swift
//  NavegacionEnAppsUIKit
//
//  Created by Rubén Segura Romo on 28/3/25.
//

import UIKit

class SheetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
	/// Este metodo cierra la vista actual si no hay navigation controller en el storyboard y no es push
	/// porquey ya no se está haciendo el dismiss (FUNCIONA SOLO EN MODALES O SHEETS)
	@IBAction func closeView(_ sender: Any) {
		dismiss(animated: true)
	}
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
