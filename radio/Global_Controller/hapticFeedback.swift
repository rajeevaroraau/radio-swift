//
//  hapticFeedback.swift
//  Radio
//
//  Created by Marcin Wolski on 01/11/2023.
//

import UIKit
func hapticFeedback() async {
        let generator = await UINotificationFeedbackGenerator()
        await generator.notificationOccurred(.success)
        print("Haptic Used")
}


