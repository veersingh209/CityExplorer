//
//  ContentModel.swift
//  CityExplorer
//
//  Created by Veer Singh on 9/1/22.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var location = CLLocationManager()
    
    override init() {
        super.init()
        
        location.delegate = self
        
        // Ask for location permission
        location.requestWhenInUseAuthorization()
        
    }
    
    // MARK: Location Manager Methods
    // Detect if permision access changed
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // User granted location permision
        if location.authorizationStatus == .authorizedAlways ||
            location.authorizationStatus == .authorizedWhenInUse {
            
            // Start retreiving current location
            location.startUpdatingLocation()
            
            
        } else if location.authorizationStatus == .denied {
            // User denied location access
            
            
        } else if location.authorizationStatus == .restricted {
            // User denied app location access from settings
            
        }
    }
    
    
    // Get location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations.first!)
        
        // Stop location request
        location.stopUpdatingLocation()
    }
    
}
