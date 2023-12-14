//
//  AirPlayView.swift
//  Radio
//
//  Created by Marcin Wolski on 28/10/2023.
//

import Foundation
import UIKit
import SwiftUI
import AVKit
struct AirPlayButton: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        
        let routePickerView = AVRoutePickerView()
        routePickerView.backgroundColor = UIColor.clear
        routePickerView.activeTintColor = UIColor.white
        routePickerView.tintColor = UIColor.secondaryLabel
        
        return routePickerView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
