//
//  ViewController.swift
//  App2-ControlesYVistas
//
//  Created by Rubén Segura Romo on 14/4/25.
//

import UIKit

class ViewController: UIViewController {
	
	// Variables
	var numeros = ["uno", "dos", "tres", "cuatro"]

	// Outlets
	@IBOutlet weak var myButton: UIButton!
	@IBOutlet weak var myPickerView: UIPickerView!
	@IBOutlet weak var mySegmentedControl: UISegmentedControl!
	@IBOutlet weak var myPageControl: UIPageControl!
	@IBOutlet weak var mySlider: UISlider!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Buttons
		myButton.backgroundColor = .blue
		
		// Pickers
		myPickerView.backgroundColor = .blue
		myPickerView.dataSource = self
		myPickerView.delegate = self
		
		// Page Controls
		myPageControl.numberOfPages = numeros.count
		myPageControl.currentPageIndicatorTintColor = .blue
		myPageControl.pageIndicatorTintColor = .gray
		
		// Segmented Controls
		mySegmentedControl.removeAllSegments()
		for (index, value) in numeros.enumerated() {
			mySegmentedControl.insertSegment(withTitle: value, at: index, animated: true)
		}
		
		// Sliders
		mySlider.minimumTrackTintColor = .red
		mySlider.minimumValue = 1
		mySlider.maximumValue = Float(numeros.count)
		mySlider.value = 1
	}

	// Actions
	@IBAction func colorBtnAction(_ sender: Any) {
		if myButton.tintColor == .blue {
			myButton.tintColor = .cyan
		} else {
			myButton.tintColor = .blue
		}
	}
 
	
	@IBAction func myPageControlAction(_ sender: Any) {
		myButton.setTitle(numeros[myPageControl.currentPage], for: .normal)
		myPickerView.selectRow(myPageControl.currentPage, inComponent: 0, animated: true)
		mySegmentedControl.selectedSegmentIndex = myPageControl.currentPage
	}
	
	@IBAction func mySegmentedControlAction(_ sender: Any) {
		myButton.setTitle(numeros[mySegmentedControl.selectedSegmentIndex], for: .normal)
		myPickerView.selectRow(mySegmentedControl.selectedSegmentIndex, inComponent: 0, animated: true)
	}
	
	@IBAction func mySliderAction(_ sender: Any) {
		switch mySlider.value {
			case 1..<2:
				mySegmentedControl.selectedSegmentIndex = 0
				myButton.setTitle(numeros[0], for: .normal)
				myPickerView.selectRow(0, inComponent: 0, animated: true)
			case 2..<3:
				mySegmentedControl.selectedSegmentIndex = 1
				myButton.setTitle(numeros[1], for: .normal)
				myPickerView.selectRow(2, inComponent: 0, animated: true)
			case 3..<4:
				mySegmentedControl.selectedSegmentIndex = 2
				myButton.setTitle(numeros[2], for: .normal)
				myPickerView.selectRow(2, inComponent: 0, animated: true)
			case 4..<5:
				mySegmentedControl.selectedSegmentIndex = 3
				myButton.setTitle(numeros[3], for: .normal)
				myPickerView.selectRow(3, inComponent: 0, animated: true)
			default:
				mySegmentedControl.selectedSegmentIndex = 0
		}
	}
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		numeros.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		numeros[row]
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		myButton.setTitle(numeros[row], for: .normal)
		myPageControl.currentPage = row
		mySegmentedControl.selectedSegmentIndex = row
	}
}

