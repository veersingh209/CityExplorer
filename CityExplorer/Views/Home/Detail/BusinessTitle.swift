//
//  BusinessTitle.swift
//  CityExplorer
//
//  Created by Veer Singh on 9/16/22.
//

import SwiftUI

struct BusinessTitle: View {
    
    var business: Businesses
    
    var body: some View {
        
        VStack (alignment: .leading){
            
            Text(business.name!)
                .font(.largeTitle)
                .padding(.leading)
            
            if business.location?.displayAddress != nil {
                
                ForEach(business.location!.displayAddress!, id: \.self) { address in
                    Text(address)
                        .padding([.leading])
                }
                
            }
            
            Image("regular_\(business.rating ?? 0)")
                .padding([.leading, .bottom])
            
        }
        
    }
}
