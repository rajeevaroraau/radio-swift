import SwiftUI

struct CountryRow: View {
    var country: Country
    var body: some View {
        VStack(alignment: .leading) {
            Text(country.name)
            Text("\(country.stationcount) stations")
                .foregroundStyle(.secondary)
        }
    }
}


