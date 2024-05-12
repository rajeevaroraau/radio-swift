//
//  NetworkMonitor.swift
//  Radio
//
//  Created by Marcin Wolski on 29/03/2024.
//

import Foundation
import Network
import SwiftUI

@Observable
class NetworkMonitor {
    
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    
    var isConnected = false

    init() {
        networkMonitor.pathUpdateHandler = { path in
            withAnimation {
                self.isConnected = path.status == .satisfied
            }
            
        }
        networkMonitor.start(queue: workerQueue)
    }

}
