//
//  HomeScreenViewController.swift
//  ParkStashCodingChallenge
//
//  Created by admin on 1/23/18.
//  Copyright © 2018 ntdhat. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class HomeScreenViewController: UIViewController {
    var viewModel: HomeScreenViewModel = HomeScreenViewModel()
    
    @IBOutlet weak var mapView: MKMapView!
    
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.getAnnotations()
        
        let initialLocation = CLLocation(latitude: 37.3695, longitude: -121.9283)
        centerMapOnLocation(location: initialLocation)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func displayAnnotationsOnMap() {
        let annotations = viewModel.annotations
        mapView.addAnnotations(annotations)
    }
}

extension HomeScreenViewController: HomeScreenViewModelDelegate {
    func didRetrieveAnnotations(success: Bool) {
        displayAnnotationsOnMap()
    }
    func didAddAnnotation(success: Bool, annotation: PSAnnotation?) {
        
    }
}
