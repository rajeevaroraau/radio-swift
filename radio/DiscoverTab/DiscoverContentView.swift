import SwiftUI
import OSLog

struct DiscoverContentView: View {
    @State var countriesModel = CountriesController.shared
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
        .onAppear { Logger.viewCycle.info("DiscoverContentView appeared") }
    }
}





