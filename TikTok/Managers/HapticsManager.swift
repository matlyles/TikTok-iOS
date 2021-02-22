//
//  HapticsManager.swift
//  TikTok
//
//  Created by Matthew Lyles on 2/20/21.
//

import Foundation
import UIKit

final class HapticsManager {
    
    public static let shared = HapticsManager()
    private init() {}
    
    // Public Methods
    public func vibrateForSelection(for type: UINotificationFeedbackGenerator.FeedbackType) {
        DispatchQueue.main.async {
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(type)
        }
    }
    
}

