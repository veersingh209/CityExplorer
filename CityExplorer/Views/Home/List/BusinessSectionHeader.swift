//
//  BusinessSectionHeader.swift
//  CityExplorer
//
//  Created by Veer Singh on 9/1/22.
//

import SwiftUI

struct BusinessSectionHeader: View {
    let sectionText: String
    
    var body: some View {
        
        ZStack (alignment: .leading) {
            
            Rectangle()
                .foregroundColor(.white)
            
            Text(sectionText)
                .font(.headline)
            
        }
        
    }
}
