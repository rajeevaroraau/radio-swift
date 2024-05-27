





//
//  CountriesListContentView.swift
//  Radio
//
//  Created by Marcin Wolski on 09/12/2023.
//

import SwiftUI
import OSLog

struct CountriesListContentView: View {
    @Environment(StationsOfCountryViewController.self) private var stationsController: StationsOfCountryViewController
    @State private var firstTime: Bool = true
    @Environment(CountriesController.self) private var countriesController: CountriesController
    
    var body: some View {
        Group {
            if countriesController.countries.isEmpty {
                LoadingView()
            } else {
                CountriesView()
            }
        }
        .navigationTitle("Countries")
        .task { await countriesController.fetchCountries() }
        .onAppear { Logger.viewCycle.info("CountriesListContentView appeared") }
    }
}
