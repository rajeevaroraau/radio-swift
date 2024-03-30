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
    func averageColor() async -> Color? {
        os_signpost(.begin, log: pOI, name: "averageColor Calculation")
        guard let inputImage = CIImage(image: self) else {
            os_signpost(.end, log: pOI, name: "averageColor Calculation");
            return nil
        }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else {
            os_signpost(.end, log: pOI, name: "averageColor Calculation");
            return nil
        }
        guard let outputImage = filter.outputImage else {
            os_signpost(.end, log: pOI, name: "averageColor Calculation");
            return nil
        }
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
        let multiplicator = 1.4
        
        let topLimit: CGFloat = 300
        let uiColor = UIColor(
            red: CGFloat(bitmap[0]) * multiplicator / topLimit,
            green: CGFloat(bitmap[1]) * multiplicator / topLimit,
            blue: CGFloat(bitmap[2]) * multiplicator / topLimit,
            alpha: CGFloat(255) / 255)
        let color = Color(uiColor)
        os_signpost(.end, log: pOI, name: "averageColorCalc")
        return color
        
    }
}
