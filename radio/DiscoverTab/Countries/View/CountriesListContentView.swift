





//
//  CountriesListContentView.swift
//  Radio
//
//  Created by Marcin Wolski on 09/12/2023.
//

import SwiftUI
import OSLog

struct CountriesListContentView: View {
    @State var countriesModel = CountriesController.shared
    @Environment(StationsOfCountryViewController.self) private var stationsModel: StationsOfCountryViewController
    @State private var firstTime: Bool = true
    
    var body: some View {
        Group {
            if countriesModel.countries.isEmpty {
                LoadingView()
            } else {
                CountriesView()
            }
        }
        .navigationTitle("Countries")
        .task { await countriesModel.fetchCountries() }
        .onAppear { Logger.viewCycle.info("CountriesListContentView appeared") }
    }
}
