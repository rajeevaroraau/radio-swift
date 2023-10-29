//
//  measureTime.swift
//  Radio
//
//  Created by Marcin Wolski on 12/10/2023.
//

import Foundation

public class DiagnosticsMarker {
    var printingEnabled: Bool = true
    let prefix: String

    private var start = CFAbsoluteTimeGetCurrent()

    public init(prefix: String = "") {
        self.prefix = prefix
    }

    public func resetTime() {
        start = CFAbsoluteTimeGetCurrent()
    }

    public func printCheckpoint(with text: String) {
        guard printingEnabled else { return }
        let now = CFAbsoluteTimeGetCurrent()
        var message = "\(text) took \(now - start)"
        if prefix.count > 0 {
            message = "[\(prefix)]: \(message)"
        }
        print(message)
        start = now
    }
}
