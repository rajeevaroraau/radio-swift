//
//  LoggerExtension.swift
//  Radio
//
//  Created by Marcin Wolski on 11/05/2024.
//


import OSLog

extension Logger {
    private static let subsystem: String = {
        guard let bundleIdentifier = Bundle.main.bundleIdentifier else {
            return "marcin.jan.radio" // Fallback to a default value if not available
        }
        return bundleIdentifier
    }()

    /// Logs the view cycles like a view that appeared.
    static let viewCycle = Logger(subsystem: subsystem, category: "viewcycle")
    /// All logs related to tracking and analytics.
    static let statistics = Logger(subsystem: subsystem, category: "statistics")
    static let audioController = Logger(subsystem: subsystem, category: "AudioController")
    static let lockscreenController = Logger(subsystem: subsystem, category: "LockscreenController")
    static let playerState = Logger(subsystem: subsystem, category: "PlayerState")
    static let favouriteStationIntent = Logger(subsystem: subsystem, category: "FavouriteStation Intent")
    static let cachingManager = Logger(subsystem: subsystem, category: "CachingManager")
    static let playingStationManager = Logger(subsystem: subsystem, category: "PlayingStationManager")
    static let imageToData = Logger(subsystem: subsystem, category: "imageToData")
    static let countryNetworking = Logger(subsystem: subsystem, category: "CountryNetworking")
    static let countriesController = Logger(subsystem: subsystem, category: "CountriesController")
    static let stationsOfCountryNetworking = Logger(subsystem: subsystem, category: "StationsOfCountryNetworking")
    static let stationsSearchNetworking = Logger(subsystem: subsystem, category: "StationsSearchNetworking")
    static let stationsOfCountryViewController = Logger(subsystem: subsystem, category: "StationsOfCountryViewController")
    static let stationsSearch = Logger(subsystem: subsystem, category: "StationsSearch")
    static let searchingStation = Logger(subsystem: subsystem, category: "SearchingStation")
    static let richStationNetworking = Logger(subsystem: subsystem, category: "RichStationNetworking")
}
