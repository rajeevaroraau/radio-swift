import SwiftUI

struct StationRowView: View {
    let faviconCached: UIImage?
    var urlFavicon: String {
        return station.favicon
    }
    @State private var opacity = 1.0
    let station: Station
    var body: some View {
        HStack {
            
            if let faviconCached = faviconCached {
                faviconCachedImageView(image: faviconCached, height: 50)
            } else {
                // CHECK IF AN FAVICONURL EXISTS
                if let url = URL(string: urlFavicon), urlFavicon.hasPrefix("https") == true {
                    
                    AsyncImage(url: url) { phase in
                        // SHOW LOADED IMAGE
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 50/6))
                                .onAppear {
                                    print("Rich favicon loaded in StationRowView")
                                }
                            // IF STILL LOADING SHOW PLACEHOLDER
                        } else {
                            ProgressView()
                                .frame(width: 50, height: 50)
                                .onAppear {
                                    print("Temporary screen loaded in StationRowView")
                                }
                            
                        }
                    }
                } else {
                    DefaultFaviconView()
                }
                
                
            }
            VStack(alignment: .leading) {
                HStack {
                    
                    Text(station.name)
                        .font(.headline)
                        .lineLimit(2)
                        .truncationMode(.tail)
                    if station == PlayingStation.shared.station {
                        Image(systemName: "waveform")
                            .opacity(opacity)
                            .animation(
                                .easeInOut(duration: 0.5)
                                .repeatForever(autoreverses: true),
                                value: opacity
                            )
                            .onAppear {
                                opacity = 0.2
                            }
                    }
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
