//
//  measureTime.swift
//  Radio
//
//  Created by Marcin Wolski on 12/10/2023.
//

import Foundation

func measureTime(_ closure: @escaping () async -> Void) async {
    let start = CFAbsoluteTimeGetCurrent()
    
    // Call the asynchronous closure and wait for it to complete
    Task {
        await closure()
        
        print("Took \(CFAbsoluteTimeGetCurrent() - start) seconds")
    }
}
