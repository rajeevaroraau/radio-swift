import SwiftUI
import OSLog

struct DiscoverContentView: View {
    @State private var countriesController = CountriesController()
    @State private var searchText = ""
    @State private var discoverModes = DiscoverMode()
    
    var body: some View {
        NavigationStack {
            DiscoverView()
                .toolbar {
                    ToolbarItemGroup(placement: .primaryAction) {
                        SearchPicker()
                    }
                    ToolbarItemGroup(placement: .topBarLeading) {
                        SourceInfoView()
                    }
                }
        }
        .environment(discoverModes)
        .environment(countriesController)
        .onAppear { Logger.viewCycle.info("DiscoverContentView appeared") }
    }
}





