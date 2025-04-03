//
//  ViewController.swift
//  Ejercicio2-MapApp
//
//  Created by Rubén Segura Romo on 3/4/25.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, @preconcurrency CLLocationManagerDelegate {

	@IBOutlet weak var map: MKMapView!
	let locationManager = CLLocationManager()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		map.delegate = self
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
		map.showsUserLocation = true
	}
	
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		
		// guard let location = locations.last else { return } Obtenemos la localización del dispositivo
		let myUbication = CLLocationCoordinate2D(latitude: 37.913674, longitude: -3.122086)
		let region = MKCoordinateRegion(center: myUbication,
										latitudinalMeters: 1000,
										longitudinalMeters: 1000)
		map.setRegion(region, animated: true)
		addPin(at: myUbication, title: "My Location", subtitle: "In latitude: \(myUbication.latitude), longitude: \(myUbication.longitude)")
	}
	
	func addPin(at coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
		let annotation = MKPointAnnotation()
		annotation.coordinate = coordinate
		annotation.title = title
		annotation.subtitle = subtitle
		map.addAnnotation(annotation)
	}


}

