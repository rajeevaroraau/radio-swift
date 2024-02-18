//
//  ImageToData.swift
//  Radio
//
//  Created by Marcin Wolski on 18/02/2024.
//

import Foundation
import SwiftUI

func imageToData() ->  Data {
    if let image = UIImage(named: "DefaultFaviconLarge"),
       let imageData = image.pngData() {
        // Now you have the data representation of the image in PNG format
        return imageData
    } else {
        print("Unable to convert UIImage to Data.")
    }
    return Data()
}
