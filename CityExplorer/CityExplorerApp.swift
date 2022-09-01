//
//  CityExplorerApp.swift
//  CityExplorer
//
//  Created by Veer Singh on 9/1/22.
//

import SwiftUI

@main
struct CityExplorerApp: App {
    var body: some Scene {
        WindowGroup {
            LandingView()
                .environmentObject(ContentModel())
        }
    }
}
