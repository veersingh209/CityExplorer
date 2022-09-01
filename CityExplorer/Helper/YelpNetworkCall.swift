//
//  YelpNetworkCall.swift
//  CityExplorer
//
//  Created by Veer Singh on 9/1/22.
//

import CoreLocation

// MARK: - YELP API Methods
final class YelpNetworkCall {
    // Hit yelp api
    static func getYelpData(category: String, location: CLLocation) {
        
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
                
                if error != nil {
                    print("ERROR! Unable to reach Yelp API: \(String(describing: error))")
                }
            }
            
            dataTask.resume()
        }
        
    }
}
