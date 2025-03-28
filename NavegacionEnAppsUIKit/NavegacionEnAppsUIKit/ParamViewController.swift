//
//  ParamViewController.swift
//  NavegacionEnAppsUIKit
//
//  Created by Rubén Segura Romo on 28/3/25.
//

import UIKit

class ParamViewController: UIViewController {

	
	@IBOutlet weak var paramLabel: UILabel!
	var paramSegue: String = ""
	
    override func viewDidLoad() {
        super.viewDidLoad()
		paramLabel.text = paramSegue
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
