//
//  BusinessSection.swift
//  CityExplorer
//
//  Created by Veer Singh on 9/1/22.
//

import SwiftUI

struct BusinessSection: View {
    
    var title: String
    var business: [Businesses]

    var body: some View {
        
        Section(header: BusinessSectionHeader(sectionText: title)) {
            
            ForEach(business) { businesses in
                
                BusinessRow(business: businesses)
                
            }
            
        }
        
    }
}
