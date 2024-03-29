//
//  NoInternet.swift
//  Radio
//
//  Created by Marcin Wolski on 29/03/2024.
//

import SwiftUI

struct NoInternetView: View {
    var body: some View {
        ContentUnavailableView(
            "No Internet Connection",
            systemImage: "wifi.exclamationmark",
            description: Text("Please check your connection and try again.")
        )
    }
}


