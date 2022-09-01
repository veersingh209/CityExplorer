//
//  YelpBusinesses.swift
//  CityExplorer
//
//  Created by Veer Singh on 9/1/22.
//

import Foundation

struct YelpBusinesses: Decodable {
    
    var businesses = [Businesses]()
    var total = 0
    var region = Region()
    
}

struct Region: Decodable {
    
    var center = Center(
        longitude: 0.0,
        latitude: 0.0
    )
    
}

struct Center: Decodable {
    
    var longitude: Double
    var latitude: Double
    
}
