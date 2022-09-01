//
//  LandingView.swift
//  CityExplorer
//
//  Created by Veer Singh on 9/1/22.
//

import SwiftUI

struct LandingView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        // Location permission give
        // Dispaly results
        if model.permissionStatus == .authorizedAlways ||
            model.permissionStatus == .authorizedWhenInUse {
            
            HomeView()
            
        } else if model.permissionStatus == .denied{
            // Permission rejected
            
        } else {
            // Location access restrcited from settings
            
        }
        
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
