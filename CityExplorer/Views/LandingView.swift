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
        
        if model.permissionStatus == .notDetermined {
            // If undetermined, show onboarding
            Welcome()
        }
        
        // Location permission given
        // Dispaly results
        else if model.permissionStatus == .authorizedAlways ||
            model.permissionStatus == .authorizedWhenInUse {
            
            HomeView()
            
        } else {
            // Location denied
            LocationDenied()
        }
        
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
