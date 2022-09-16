//
//  BusinessDetail.swift
//  CityExplorer
//
//  Created by Veer Singh on 9/13/22.
//

import SwiftUI

struct BusinessDetail: View {
    
    var business: Businesses
    @State var showDirectionsView = false
    
    var body: some View {
        
        VStack (alignment: .leading) {
            
            VStack (alignment: .leading, spacing: 0) {
                GeometryReader { geo in
                    
                    let image = UIImage(data: business.imageData ?? Data())
                    Image(uiImage: image ?? UIImage())
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                        .aspectRatio(contentMode: .fill)
                    
                }
                .ignoresSafeArea(.all, edges: .top)

                
                ZStack(alignment: .leading) {
                    
                    Rectangle()
                        .frame(height: 40)
                        .foregroundColor(business.isClosed! ? .gray : .blue)
                    
                    Text(business.isClosed! ? "Closed" : "Open")
                        .bold()
                        .padding(.leading)
                }

            }

            
            Group {
                
                BusinessTitle(business: business)
                    .padding()
                
                Divider()
                
                HStack {
                    Text("Phone:")
                        .bold()
                    Text(business.displayPhone!)
                    Spacer()
                    Link("Call", destination: URL(string: "tel\(business.phone ?? "")")!)
                }
                .padding()
                
                Divider()
                
                HStack {
                    Text("Revies:")
                        .bold()
                    Text(String(business.reviewCount ?? 0))
                    Spacer()
                    Link("Read", destination: URL(string: "\(business.url ?? "")")!)
                }
                .padding()
                
                Divider()
                
                HStack {
                    Text("Website:")
                        .bold()
                    Text(business.url ?? "")
                        .lineLimit(1)
                    Spacer()
                    Link("Visit", destination: URL(string: "\(business.url ?? "")")!)
                }
                .padding()
                
                Divider()
            }
            
            // Directions Button
            Button {
                showDirectionsView = true
            } label: {
                
                ZStack {
                    
                    Rectangle()
                        .frame(height: 48)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                    
                    Text("Directions")
                        .foregroundColor(.white)
                        .bold()
                }
                .padding()
                
            }
            .sheet(isPresented: $showDirectionsView) {
                DirectionView(business: business)
            }

            
        }
        
    }
}
