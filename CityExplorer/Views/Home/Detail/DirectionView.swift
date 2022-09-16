//
//  DirectionView.swift
//  CityExplorer
//
//  Created by Veer Singh on 9/16/22.
//

import SwiftUI

struct DirectionView: View {
    
    var business: Businesses
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                
                BusinessTitle(business: business)
                
                Spacer()
                
                if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude,
                   let name = business.name {
                    
                    Link("Open in Maps", destination: URL(string:"http://maps.apple.com/?ll=\(lat),\(long)&q=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)")!)
                }
            }
            .padding()
            
            DirectionsMap(business: business)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        
    }
}
