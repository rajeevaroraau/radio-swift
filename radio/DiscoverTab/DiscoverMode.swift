//
//  DiscoverMode.swift
//  Radio
//
//  Created by Marcin Wolski on 29/03/2024.
//

import SwiftUI

@Observable
class DiscoverMode {
    
    var mode = Modes.station
    
    enum Modes: String, CaseIterable {
        case station = "Stations"
        case country = "Countries"
    }
    
}


extension String {
    
    func localizedString() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
}
