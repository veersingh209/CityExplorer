//
//  ContentModel.swift
//  CityExplorer
//
//  Created by Veer Singh on 9/1/22.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var business = [Businesses]()
    @Published var arts = [Businesses]()
    
    var location = CLLocationManager()
    
    override init() {
        super.init()
        
        location.delegate = self
        
        // Ask for location permission
        location.requestWhenInUseAuthorization()
        
    }
    
    // MARK: - Location Manager Methods
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
        
        let userLocation = locations.first
        
        // When location is recivied
        if userLocation != nil {
            // Stop all location requests
            location.stopUpdatingLocation()
            
            // Yelp REST API call
            getYelpData(category: Constants.Categories.buinsess, location: userLocation!)
            getYelpData(category: Constants.Categories.arts, location: userLocation!)
            
            
        }
        
    }
    
    func getYelpData(category: String, location: CLLocation) {
        
        var urlCompents = URLComponents(string: Constants.API_BASE_URL)
        urlCompents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        
        let url = urlCompents?.url
        if let url = url {
            
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer \(Constants.API_KEY)", forHTTPHeaderField: "Authorization")
            
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: request) { data, respone, error in
                
                if error == nil {
                    
                    do {
                        
                        let decoder = JSONDecoder()
                        let results = try decoder.decode(YelpBusinesses.self, from: data!)
                        
                        DispatchQueue.main.async {
                            switch category {
                            case Constants.Categories.arts:
                                self.arts = results.businesses
                            case Constants.Categories.buinsess:
                                self.business = results.businesses
                            default:
                                break
                            }
                        }
                        
                    } catch {
                        print("ERROR! Unable to parse JSON Data: \(error)")
                    }
                    
                } else {
                    print("ERROR! Unable to reach Yelp API: \(String(describing: error))")
                }
            }
            
            dataTask.resume()
        }
        
    }
    
}
