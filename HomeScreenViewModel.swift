//
//  HomeScreenViewModel.swift
//  ParkStashCodingChallenge
//
//  Created by admin on 1/24/18.
//  Copyright © 2018 ntdhat. All rights reserved.
//

import Foundation
import MapKit

class PSAnnotation: NSObject, MKAnnotation {
    var model: LocationModel
    var coordinate: CLLocationCoordinate2D {
        get { return CLLocationCoordinate2D(latitude: model.lat, longitude: model.long) }
    }
    var title: String? {
        get { return model.name }
    }
    
    init(model: LocationModel) {
        self.model = model
    }
}

protocol HomeScreenViewModelDelegate {
    func didRetrieveAnnotations(success: Bool)
    func didAddAnnotation(success: Bool, annotation: PSAnnotation?)
}

class HomeScreenViewModel {
    var dataManager: DataManager
    var delegate: HomeScreenViewModelDelegate? = nil
    
    var annotations: [PSAnnotation]
    
    var annotationsCount: Int {
        get {return annotations.count}
    }
    
    init(dataManager: DataManager? = nil) {
        self.annotations = [PSAnnotation]()
        self.dataManager = dataManager ?? DataManager()
    }
    
    func getAnnotations() {
        dataManager.getLocations { [weak self] locations in
            for location in locations {
                self?.annotations.append(PSAnnotation(model: location))
            }
            self?.delegate?.didRetrieveAnnotations(success: true)
        }
    }
    
    func addAnnotation(long: Double, lat: Double, title: String?=nil) {
        let locModel = LocationModel(name: title, long: long, lat: lat)
        dataManager.addLocation(newLocation: locModel) {
            [weak self] success in
            var newAnnotation: PSAnnotation? = nil
            if success {
                newAnnotation = PSAnnotation(model: locModel)
                self?.annotations.append(newAnnotation!)
            }
            self?.delegate?.didAddAnnotation(success: success, annotation: newAnnotation)
        }
    }
}
