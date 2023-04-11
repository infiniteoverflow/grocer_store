//
//  Utils.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 15/02/23.
//

import UIKit

/// Contains utils to make your development easy
struct AppUtilities {
    
    /// Convert your hexcode to UIColor
    static func hexStringToUIColor (hex:String,alpha: CGFloat = 1.0) -> UIColor {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        var red: Double = 0.0
        var green: Double = 0.0
        var blue: Double = 0.0
        let opacity: Double = alpha
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return UIColor.gray }
        
        if length == 6 {
            red = Double((rgb & 0xFF0000) >> 16) / 255.0
            green = Double((rgb & 0x00FF00) >> 8) / 255.0
            blue = Double(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            red = Double((rgb & 0xFF000000) >> 24) / 255.0
            green = Double((rgb & 0x00FF0000) >> 16) / 255.0
            blue = Double((rgb & 0x0000FF00) >> 8) / 255.0
            
        }
        
        return UIColor(red: red, green: green, blue: blue, alpha: opacity)
    }
}
