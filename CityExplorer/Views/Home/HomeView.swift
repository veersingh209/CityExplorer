//
//  HomeView.swift
//  CityExplorer
//
//  Created by Veer Singh on 9/1/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var showMapView = false
    @State var selectedBusiness: Businesses?
    
    var body: some View {
        
        // If yelp data has loaded
        if model.restaurants.count != 0 || model.arts.count != 0 {
            
            NavigationView {
                if !showMapView {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "location")
                            Text("San Francsico, CA")
                                .bold()
                            
                            Spacer()
                            
                            Button {
                                showMapView = true
                            } label: {
                                Text("Switch to Map View")
                                    .font(.caption)
                            }
                        }
                        
                        Divider()
                        
                        BusinessList()
                        
                    }
                    .padding([.horizontal, .top])
                    .navigationBarHidden(true)
                    .buttonStyle(.plain)
                }
                else {
                    ZStack (alignment: .top) {
                        
                        BusinessMap(selectedBusiness: $selectedBusiness)
                            .ignoresSafeArea()
                            .sheet(item: $selectedBusiness) { business in
                                BusinessDetail(business: business)
                            }
                        
                        ZStack {
                            
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .frame(height: 48)
                            
                            HStack {
                                Image(systemName: "location")
                                Text("San Francsico, CA")
                                    .bold()
                                
                                Spacer()
                                
                                Button {
                                    showMapView = false
                                } label: {
                                    Text("Switch to Map View")
                                        .font(.caption)
                                }
                            }
                            .padding()
                        }
                        .padding()
                        
                    }
                    .navigationBarHidden(true)

                }
            }
            
        } else {
            ProgressView()
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
