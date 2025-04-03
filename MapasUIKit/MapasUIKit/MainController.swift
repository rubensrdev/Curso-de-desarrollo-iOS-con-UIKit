//
//  ViewController.swift
//  MapasUIKit
//
//  Created by Rubén Segura Romo on 3/4/25.
//

import UIKit
import MapKit

@MainActor
class MainController: UIViewController, @preconcurrency CLLocationManagerDelegate {

	@IBOutlet weak var mapa: MKMapView!
	
	let locationManager = CLLocationManager()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let localizacion = locations.first {
			locationManager.stopUpdatingLocation()
			renderMapWith(localizacion)
		}
	}
	
	func renderMapWith(_ location: CLLocation) {
		let coordenadas = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
		let region = MKCoordinateRegion(center: coordenadas, latitudinalMeters: 1000, longitudinalMeters: 1000)
		mapa.setRegion(region, animated: true)
		
		let pin = MKPointAnnotation()
		pin.coordinate = coordenadas
		pin.title = "Estoy aquí"
		pin.subtitle = "Latitud: \(location.coordinate.latitude), Longitud: \(location.coordinate.longitude)"
		mapa.addAnnotation(pin)
	}

}

