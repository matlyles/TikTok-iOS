//
//  UIImageView+Ext.swift
//  TikTok
//
//  Created by Matthew Lyles on 5/3/21.
//

import UIKit

extension UIImageView {
    
    func addBorder(stroke: CGFloat, color: CGColor) {
        layer.borderWidth = stroke
        layer.borderColor = color
    }
    
}
