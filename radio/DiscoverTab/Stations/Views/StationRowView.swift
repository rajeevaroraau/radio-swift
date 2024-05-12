import SwiftUI

struct StationRowView: View {
    @State private var opacity = 1.0
    let faviconCached: UIImage?
    let station: StationBase
    
    var body: some View {
        HStack {
            DynamicImageFaviconView(faviconCached: faviconCached, urlFavicon: station.favicon)
            VStack(alignment: .leading) {
                Text(station.name).font(.headline).lineLimit(2).truncationMode(.tail)
                Text("\(station.votes) likes")
                    .foregroundStyle(.secondary)
                    .font(.caption)
            }
        }
        .contentShape(Rectangle())
    }
}

struct DefaultFaviconView: View {
    @State private var height: CGFloat = 48
    
    var body: some View {
        Image(uiImage: UIImage(named: "DefaultFaviconSmall")!)
            .resizable()
            .scaledToFit()
            .frame(width: height, height: height)
            .clipShape(RoundedRectangle(cornerRadius: height/6))
    }
}
