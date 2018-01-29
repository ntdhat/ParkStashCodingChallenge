//
//  LocationModel.swift
//  ParkStashCodingChallenge
//
//  Created by admin on 1/23/18.
//  Copyright © 2018 ntdhat. All rights reserved.
//

import Foundation

struct LocationModel {
    let name: String
    let long: Double
    let lat: Double
    
    init(name: String?, long:Double, lat:Double) {
        self.name = name ?? ""
        self.long = long
        self.lat = lat
    }
    
    init(long:Double, lat:Double) {
        self.init(name: "", long: long, lat: lat)
    }
}
