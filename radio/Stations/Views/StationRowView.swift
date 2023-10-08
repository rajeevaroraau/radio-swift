import SwiftUI
import AVFoundation
struct StationRowView: View {
    let name: String
    let favicon: UIImage?
    let urlFavicon: String?
    @State private var opacity = 1.0
    var isPlaying: Bool
    let votes: Int
    var body: some View {
        
        
        
        HStack {
            
            if let favicon = favicon {
                cachedFaviconImage(image: favicon, height: 50)
                
            } else {
                if let urlFavicon = urlFavicon {
                    AsyncImage(url: URL(string: urlFavicon)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 50/6))
                                
                            
                        } else {
                            Image(uiImage: UIImage(named: "DefaultFavicon")!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 50/6))
                        }
                }
            }

                
            }

            
                VStack(alignment: .leading) { 
                    HStack {
                        
                        Text(name)
                            .font(.headline)
                        if isPlaying {
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
                    Text("\(votes) votes")
                        .foregroundStyle(.secondary)
                        .font(.caption)
                }
                
                
                
            }
        .contentShape(Rectangle())


            
    }
        
        
}

