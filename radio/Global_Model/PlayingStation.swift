//
//  PlayingStation.swift
//  Radio
//
//  Created by Marcin Wolski on 06/10/2023.
//

import Foundation
import SwiftUI
import SwiftData
import Observation

@Model
class PlayingStation {
    static var shared = PlayingStation()
    
    // ACTUAL MODEL
    private(set) var station: Station? = nil
    //RAW FAVICON DATA
    var faviconData: Data? = nil
    
    var faviconUIImage: UIImage? {
        if let faviconData = faviconData {
            return UIImage(data: faviconData)
        }
        return nil
        
    }
    
    init(faviconData: Data? = nil, station: Station? = nil) {
        self.faviconData = faviconData
        self.station = station
    }
    
    
    
    func fetchFavicon() async {
        
        guard let station = self.station else {
            print("No station in fetchFavicon()");
            return
        }
        
        print("fetchFavicon: Found a station in PlayingStation.station: \(station.name)")
        
        await MainActor.run {
            self.faviconData = nil
        }
        

        // CACHE THE COVER ART
        if let faviconURL = URL(string: station.favicon) {
            print("faviconURL found")

            
            do {
                print("Starting to fetching data from favicon url")
                let (data, _) = try await URLSession.shared.data(from: faviconURL)

                    await MainActor.run {
                        self.faviconData =  data
                    }
                
                
                print("Fetched PlayingStation Favicon")
            } catch {
                print("Cannot cache the station")
                await MainActor.run {
                    self.faviconData = nil
                }
            }
            
        } else {
            print("No favicon link")
            await MainActor.run {
                self.faviconData = nil
            }
        }
    }
    
    func setStationWithFetchingFavicon(_ station: Station) {


        print("Setting known info for PlayingStation")
  
        Task {
            await MainActor.run {
                self.station = station
            }
        }
        
        
        Task {
            await fetchFavicon()
        }
        
    
        print("Setting station for PlayingStation (async)")
    }
    
    func setStation(_ stationToSet: Station, faviconCached data: Data?)  {
        withAnimation {
            
            self.station = stationToSet
            print("PlayingStation's station is set! \(stationToSet.name)")
            
            guard let data = data else {
                print("No data in PlayingStation's setStation");
                Task {
                    await MainActor.run {
                        self.faviconData = nil;
                    }
                }
                
                return
            }
            
            Task {
                await MainActor.run {
                    self.faviconData = data
                }
            }
 
            
            
        }
    }
    
    
}
