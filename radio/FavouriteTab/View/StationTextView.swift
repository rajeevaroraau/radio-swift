//
//  StationTextView.swift
//  Radio
//
//  Created by Marcin Wolski on 29/03/2024.
//

import SwiftUI

struct StationTextView: View {
    let stationName: String
    let textAlignment: TextAlignment
    let textSize: Font
    let fontDesign: Font.Design
    var body: some View {
        
            Text(stationName)
                .font(textSize)
                .multilineTextAlignment(textAlignment)
                .lineLimit(2)
                .truncationMode(.tail)
                .fontDesign(fontDesign)
            
        
    }
}
