//
//  ViewController.swift
//  TestPlaces
//
//  Created by John Doe on 02.06.2024.
//

import UIKit
import Libraries
import UI

class ViewController: LBNavigationController {

	override func viewDidLoad() {
		super.viewDidLoad()
        let placesView = TSPlacesView(frame: self.view.bounds)
        let vc = LBViewController(preloadedView: placesView)
		self.pushViewController(vc, animated: false)
	}


}

