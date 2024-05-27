//
//  CountriesListView.swift
//  Radio
//
//  Created by Marcin Wolski on 09/12/2023.
//

import SwiftUI
import OSLog

struct CountriesView: View {
    @Environment(StationsOfCountryViewController.self) private var stationsController: StationsOfCountryViewController
    @State private var firstTime: Bool = true
    @Environment(CountriesController.self) private var countriesController: CountriesController
    var body: some View {
        @Bindable var countriesController = countriesController
        List {
            ForEach(countriesController.searchableCountries, id: \.iso_3166_1) { country in
                NavigationLink  {
                    StationsOfCountryContentView(country: country)
                } label: {
                    CountryRow(country: country)
                }
            }
        }
        .listStyle(.inset)
        .searchable(
            text: $countriesController.searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search for countries")
        .disableAutocorrection(true)
        .contentMargins(.bottom, 96, for: .automatic)
    }
}
