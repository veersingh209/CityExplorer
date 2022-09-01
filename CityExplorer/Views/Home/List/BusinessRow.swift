//
//  BusinessRow.swift
//  CityExplorer
//
//  Created by Veer Singh on 9/1/22.
//

import SwiftUI

struct BusinessRow: View {
    
    var business: Businesses
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                
                let image = UIImage(data: business.imageData ?? Data())
                Image(uiImage: image ?? UIImage())
                    .resizable()
                    .frame(width: 58, height: 58)
                    .cornerRadius(15)
                    .scaledToFit()
                
                VStack(alignment: .leading) {
                    Text(business.name ?? "")
                        .bold()
                    Text(String(format: "%.1f km away", (business.distance ?? 0/1000) ))
                        .font(.caption)
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    
                    Image("regular_\(business.rating ?? 0)")
                    Text("\(business.reviewCount ?? 0) Reviews")
                        .font(.caption)
                    
                }
            }
            
            Divider()
        }
        
    }
}
