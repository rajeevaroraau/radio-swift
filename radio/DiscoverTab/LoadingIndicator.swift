//
//  LoadingIndicator.swift
//  Radio
//
//  Created by Marcin Wolski on 30/03/2024.
//

import SwiftUI

struct LoadingIndicator: View {
    @Environment(LoadingIndicatorController.self) private var loadingIndicatorController: LoadingIndicatorController
    
    var body: some View {
        if loadingIndicatorController.isLoading {
            ProgressView()
        } else {
            EmptyView()
        }
    }
}


@Observable
class LoadingIndicatorController {
    var isLoading = false
}
