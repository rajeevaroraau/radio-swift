//
//  averageUIColor.swift
//  Radio
//
//  Created by Marcin Wolski on 12/10/2023.
//

import Foundation
import SwiftUI

import OSLog

extension UIImage {
    var averageColor: Color? {
        os_signpost(.begin, log: pointsOfInterest, name: "averageColor Calculation")
        
        guard let inputImage = CIImage(image: self) else {
            os_signpost(.end, log: pointsOfInterest, name: "averageColor Calculation");
            return nil
        }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
        
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else {
            os_signpost(.end, log: pointsOfInterest, name: "averageColor Calculation");
            return nil
        }
        guard let outputImage = filter.outputImage else {
            os_signpost(.end, log: pointsOfInterest, name: "averageColor Calculation");
            return nil
        }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
        let color = Color(UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255))
        os_signpost(.end, log: pointsOfInterest, name: "averageColor Calculation")
        
        return color
        
    }
}
