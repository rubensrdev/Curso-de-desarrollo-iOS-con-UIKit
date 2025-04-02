//
//  ModeloViewModel.swift
//  JSONENUIKit
//
//  Created by Rubén Segura Romo on 2/4/25.
//

import Foundation

@MainActor
final class ModeloViewModel {
	
	public static let shared = ModeloViewModel()
	
	var datosModelo = Modelo(data: [])
	
	func fetch(completion: @escaping (_ done: Bool) -> Void){
		guard let url = URL(string: "https://reqres.in/api/users?page=2") else { return  }
		
		URLSession.shared.dataTask(with: url){data,_,_ in
			
			guard let data = data else { return }
			do{
				let json = try JSONDecoder().decode(Modelo.self, from: data)
				DispatchQueue.main.async {
					self.datosModelo = json
					completion(true)
				}
			}catch let error as NSError{
				print("Error en el json", error.localizedDescription)
			}
			
		}.resume()
	}
}
