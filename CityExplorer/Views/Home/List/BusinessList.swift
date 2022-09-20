//
//  BusinessList.swift
//  CityExplorer
//
//  Created by Veer Singh on 9/1/22.
//

import SwiftUI

struct BusinessList: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        ScrollView {
            
            LazyVStack(alignment: .leading, spacing: 0.0, pinnedViews: .sectionHeaders) {
                
                BusinessSection(title: "Resturants", business: model.restaurants)
                    .padding(.bottom)
                BusinessSection(title: "Others", business: model.arts)
                    .padding(.bottom)
                
            }

        }
        
    }
}
