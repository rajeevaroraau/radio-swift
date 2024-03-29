import SwiftUI

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
                        
                        Label(
                            title: { Text("Data from radio-browser.info") },
                            icon: { Image(systemName: "info.circle") }
                        )
                            .foregroundStyle(.secondary)
                            .labelStyle(.titleAndIcon)
                            .font(.caption2)

                    }
                }
        }
        .environment(discoverModes)
    }
}





