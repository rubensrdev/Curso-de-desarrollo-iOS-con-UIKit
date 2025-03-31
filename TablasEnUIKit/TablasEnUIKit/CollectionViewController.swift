//
//  CollectionViewController.swift
//  TablasEnUIKit
//
//  Created by Rubén Segura Romo on 31/3/25.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

	@IBOutlet weak var grid: UICollectionView!
	
	var contactos: [Contacto] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		grid.delegate = self
		grid.dataSource = self
		
		navigationBarStyle()
		cargarContactos()
    }
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		contactos.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celda", for: indexPath) as! CeldaCollectionViewCell
		let list = contactos[indexPath.row]
		cell.nombre.text = list.nombre
		cell.telefono.text = list.telefono
		cell.imagen.image = UIImage(systemName: "person.fill")
		return cell
	}
    
	/// Cambia el color de fondo de la barra de navegación
	func navigationBarStyle() {
		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()
		appearance.backgroundColor = UIColor.systemIndigo
		appearance.titleTextAttributes = [.foregroundColor: UIColor.white] //
		navigationController?.navigationBar.standardAppearance = appearance
		navigationController?.navigationBar.scrollEdgeAppearance = appearance
	}
	
	/// Lleno la lista de contactos con datos de ejemplo
	func cargarContactos() {
		contactos.append(Contacto(nombre: "Rubén", telefono: "123456789"))
		contactos.append(Contacto(nombre: "Juan", telefono: "987654321"))
		contactos.append(Contacto(nombre: "Pedro", telefono: "123456789"))
		contactos.append(Contacto(nombre: "Ana", telefono: "987654321"))
		contactos.append(Contacto(nombre: "María", telefono: "123456789"))
	}
}
