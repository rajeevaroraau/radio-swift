import SwiftUI

struct StationRowView: View {
    let faviconCached: UIImage?
    
    @State private var opacity = 1.0
    let station: Station
    var body: some View {
        HStack {
            DynamicImageFaviconView(faviconCached: faviconCached, urlFavicon: station.favicon)
            VStack(alignment: .leading) {
                
                if station.stationuuid == PlayingStation.shared.station?.stationuuid {
                    Text(station.name).font(.headline).lineLimit(2).truncationMode(.tail)
                        .opacity(opacity)
                        .animation(
                            .easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true),
                            value: opacity
                        )
                        .onAppear {
                            opacity = 0.2
                        }
                } else {
                    Text(station.name).font(.headline).lineLimit(2).truncationMode(.tail)
                }
                
                Text("\(station.votes) likes")
                    .foregroundStyle(.secondary)
                    .font(.caption)
            }
        }
        .contentShape(Rectangle())
        
    }
}




struct DefaultFaviconView: View {
    var body: some View {
        Image(uiImage: UIImage(named: "DefaultFaviconSmall")!)
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .clipShape(RoundedRectangle(cornerRadius: 50/6))
    }
}
