import SwiftUI
import Network

@Observable
class Connection {
    static var defaultURL = "https://de1.api.radio-browser.info/json/"
    
    static func baseURL() -> String {
        let baseURL  = UserDefaults.standard.string(forKey: "baseURL")
        return baseURL ?? defaultURL
    }
    
}
