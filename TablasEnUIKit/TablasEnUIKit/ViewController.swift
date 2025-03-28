//
//  ViewController.swift
//  TablasEnUIKit
//
//  Created by Rubén Segura Romo on 28/3/25.
//

import UIKit

struct Contacto {
	var nombre: String
	var telefono: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var tabla: UITableView!
	
	var contactos: [Contacto] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Se establece que el controlador actual (self) actuará como delegado (delegate)
		// y fuente de datos (dataSource) de la tabla.
		//
		// Esto significa que este controlador implementará los métodos necesarios para:
		// - Proveer los datos a la tabla (número de filas, contenido de cada celda, etc.)
		// - Gestionar eventos relacionados con la tabla (selección de celdas, altura de filas, etc.)
		//
		// Es imprescindible que la clase adopte los protocolos UITableViewDelegate y UITableViewDataSource.
		tabla.delegate = self
		tabla.dataSource = self
		
		navigationBarStyle()
		cargarContactos()
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
	
	/// Método delegado de UITableViewDataSource que indica cuántas filas debe mostrar la tabla en una sección dada.
	///
	/// - Parameters:
	///   - tableView: La instancia de UITableView que realiza la consulta.
	///   - section: El índice de la sección (en este caso siempre será 0 si solo hay una sección).
	/// - Returns: El número total de filas (celdas) que se deben mostrar en la sección especificada.
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return contactos.count
	}
	
	/// Método delegado de UITableViewDataSource que devuelve una celda configurada para una fila específica de la tabla.
	///
	/// - Parameters:
	///   - tableView: La instancia de UITableView que solicita la celda.
	///   - indexPath: La posición (sección y fila) de la celda que se está pidiendo.
	/// - Returns: Una instancia de UITableViewCell ya configurada para mostrarse en la tabla.
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tabla.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
		let list = contactos[indexPath.row]
		cell.textLabel?.text = list.nombre
		cell.detailTextLabel?.text = list.telefono
		return cell
	}
	
	/// Método delegado de UITableViewDelegate que se llama cuando el usuario selecciona una fila de la tabla.
	/// Al seleccionar una fila, se inicia una transición (segue) hacia otra vista (detalle).
	/// - Parameters:
	///   - tableView: La instancia de UITableView que gestiona la interacción.
	///   - indexPath: La posición (sección y fila) de la celda seleccionada.
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "detalle", sender: self)
	}
	
	/// Método llamado automáticamente justo antes de realizar una transición (segue) entre controladores.
	/// Sirve para preparar y transferir información desde el controlador origen al controlador destino.
	///
	/// - Parameters:
	///   - segue: El objeto UIStoryboardSegue que contiene información sobre la transición (incluye el destino).
	///   - sender: El objeto que inició el segue (normalmente 'self' o la celda seleccionada).
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// Verifica que el segue que se va a ejecutar es el esperado (identificador definido en el storyboard).
		if segue.identifier == "detalle" {
			// Obtiene el indexPath de la fila seleccionada en la tabla, si existe.
			if let id = tabla.indexPathForSelectedRow {
				// Se accede al modelo de datos correspondiente a la fila seleccionada.
				let fila = contactos[id.row]
				// Se obtiene una referencia al controlador de destino, haciendo un cast seguro al tipo esperado.
				let destino = segue.destination as? CellDetailViewController
				// Se transfiere el objeto 'fila' (un contacto) al controlador de destino.
				// Es necesario que 'CellDetailViewController' tenga una propiedad pública llamada 'contacto'.
				destino?.contacto = fila
			}
		}
	}

}

