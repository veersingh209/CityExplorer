//
//  Welcome.swift
//  CityExplorer
//
//  Created by Veer Singh on 9/20/22.
//

import SwiftUI

struct Welcome: View {
    
    @EnvironmentObject var model: ContentModel
    @State private var tabSelection = 0
    
    private let blue = Color(red: 0/255, green: 130/255, blue: 167/255)
    private let turquoise = Color(red: 55/255, green: 197/255, blue: 192/255)
    
    var body: some View {
        
        VStack(spacing: 0.0) {
            
            TabView(selection: $tabSelection) {
                
                // Tab1
                VStack (spacing: 20) {
                    Image("city2")
                        .resizable()
                        .scaledToFit()
                    Text("Welcome to City Explorer!")
                        
                        .bold()
                        .font(.title)
                    Text("See the best your city has to offer!")
                }
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.white)
                .tag(0)
                
                // Tab2
                VStack (spacing: 20) {
                    Image("city1")
                        .resizable()
                        .scaledToFit()
                    Text("Ready to discover your city?")
                        .bold()
                        .font(.title)
                    Text("We only use your approximate location to find the best attractions near you")
                    Text("Location access can always be revocked in the settings")
                        .font(.caption)
                }
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.white)
                .tag(1)
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            
            // Button
            Button {
                
                if tabSelection == 0 {
                    tabSelection = 1
                }
                else {
                    model.getLocation()
                }
                
            } label: {
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)
                    
                    Text( tabSelection == 0 ? "Next" : "Get My Location")
                        .bold()
                        .padding()
                }
                
            }
            .accentColor(tabSelection == 0 ? blue : turquoise)
            .padding()

            
            Spacer()
        }
        .background(tabSelection == 0 ? blue : turquoise)
        .ignoresSafeArea(.all, edges: .all)
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}
