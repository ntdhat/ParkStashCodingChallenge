//
//  DataManager.swift
//  ParkStashCodingChallenge
//
//  Created by admin on 1/24/18.
//  Copyright © 2018 ntdhat. All rights reserved.
//

import Foundation

class DataManager {
    var storage: UserDefaults = UserDefaults.standard
}

extension DataManager {
    
    func getLocations(completion: (([LocationModel])->Void)?) {
        var locations = [LocationModel]()

        if let data = storage.object(forKey: "locations") as? [[String:Any]] {
            for item in data {
                guard let long = item["long"] as? Double,
                    let lat = item["lat"] as? Double
                    else { continue }
                let name = item["name"] as? String
                let aLocation = LocationModel(name: name, long: long, lat: lat)
                locations.append(aLocation)
            }
        }

        completion?(locations)

        return
    }
    
    func addLocation(newLocation: LocationModel, completion: ((Bool)->())?) {
        var currentData = (storage.object(forKey: "locations") as? [[String:Any]]) ?? [[String:Any]]()
        let newDict: [String:Any] = ["long": newLocation.long, "lat": newLocation.lat, "name": newLocation.name]
        currentData.append(newDict)
        storage.set(currentData, forKey: "locations")
        completion?(true)
    }
}
