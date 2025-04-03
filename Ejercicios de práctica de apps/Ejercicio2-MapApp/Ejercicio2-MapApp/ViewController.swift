//
//  ViewController.swift
//  Ejercicio2-MapApp
//
//  Created by Rubén Segura Romo on 3/4/25.
//

import UIKit
import MapKit


/// Controlador principal que gestiona un mapa con localización del usuario, anotaciones fijas y búsqueda de lugares mediante `UISearchBar`.
class ViewController: UIViewController, MKMapViewDelegate, @preconcurrency CLLocationManagerDelegate, UISearchBarDelegate {
	
	/// Barra de búsqueda usada para introducir nombres de lugares.
	@IBOutlet weak var searchBarForLocations: UISearchBar!
	
	/// Vista de mapa que muestra la localización, pines y resultados de búsqueda.
	@IBOutlet weak var map: MKMapView!
	
	/// Gestor de localización para obtener la ubicación actual del dispositivo.
	let locationManager = CLLocationManager()
	
	/// Bandera para detectar si el usuario ha movido manualmente el mapa y evitar que se recoloque automáticamente.
	var userHasMovedMap = false
	
	/// Método llamado al cargar la vista. Configura delegados, permisos de localización y opciones del mapa.
	override func viewDidLoad() {
		super.viewDidLoad()
		map.delegate = self
		searchBarForLocations.delegate = self
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
		map.showsUserLocation = true
	}
	
	/// Método delegado que se llama cada vez que se actualiza la localización del dispositivo.
	/// - Muestra la ubicación del usuario en el mapa y centra la vista (salvo que el usuario haya interactuado manualmente).
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard !userHasMovedMap else { return }
		
		let myUbication = CLLocationCoordinate2D(latitude: 37.913674, longitude: -3.122086)
		let region = MKCoordinateRegion(center: myUbication,
										latitudinalMeters: 1000,
										longitudinalMeters: 1000)
		map.setRegion(region, animated: true)
		
		addPin(at: myUbication, title: "My Location", subtitle: "In latitude: \(myUbication.latitude), longitude: \(myUbication.longitude)")
		showDifferentPins()
	}
	
	/// Añade un pin (anotación) en el mapa en una coordenada concreta.
	/// - Parameters:
	///   - coordinate: Coordenada geográfica donde colocar el pin.
	///   - title: Título del pin que se mostrará en el mapa.
	///   - subtitle: Subtítulo del pin (opcional).
	func addPin(at coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
		let annotation = MKPointAnnotation()
		annotation.coordinate = coordinate
		annotation.title = title
		annotation.subtitle = subtitle
		map.addAnnotation(annotation)
	}
	
	/// Muestra una serie de puntos de interés fijos predefinidos añadiendo anotaciones al mapa.
	func showDifferentPins() {
		let places: [(String, Double, Double)] = [
			("Park Felix Rodríguez de la Fuente", 37.913718, -3.121702),
			("Footbal Field La Nava", 37.915479, -3.116025),
			("Mocha and Clock Towers", 37.912038, -3.127036)
		]
		
		for (name, latitude, longitude) in places {
			let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
			addPin(at: coordinate, title: name, subtitle: nil)
		}
	}
	
	/// Método delegado de `MKMapView` que se activa cuando el usuario comienza a mover el mapa.
	/// - Establece la bandera `userHasMovedMap` para evitar recolocaciones automáticas.
	func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
		userHasMovedMap = true
	}
	
	/// Método delegado de `UISearchBar` que se ejecuta cuando el usuario pulsa el botón de búsqueda del teclado.
	/// - Realiza una búsqueda geográfica del texto introducido y actualiza el mapa.
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let text = searchBar.text, !text.isEmpty else { return }
		userHasMovedMap = true
		searchPlace(text)
		searchBar.resignFirstResponder()
	}
	
	/// Realiza una búsqueda de un lugar en el mapa utilizando `MKLocalSearch`.
	/// - Parameter place: Cadena con el nombre del lugar a buscar.
	/// - Añade un pin en la ubicación encontrada y centra la vista en ella.
	func searchPlace(_ place: String) {
		let request = MKLocalSearch.Request()
		request.naturalLanguageQuery = place
		request.region = map.region

		let search = MKLocalSearch(request: request)
		search.start { response, error in
			guard let item = response?.mapItems.first else { return }

			let coordinate = item.placemark.coordinate
			self.addPin(at: coordinate, title: item.name, subtitle: item.placemark.title)

			let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
			self.map.setRegion(region, animated: true)
		}
	}
}
