//
//  Utils.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 15/02/23.
//

import UIKit

/// Contains utils to make your development easy
struct Utils {
    
    /// MockData if the API fails to return the data
    static var mockData: [String:Any?] = [
        "status": "success",
        "error": nil,
        "data": [
            "items": [[
                "name": "Item 1",
                "price": "₹ 100",
                "image": "https://imgstatic.phonepe.com/images/dark/app-icons-ia-1/transfers/80/80/ic_check_balance.png",
                "extra": "Same day shipping"
            ], [
                "name": "Item 2",
                "price": "₹ 400",
                "image": "https://imgstatic.phonepe.com/images/dark/app-icons-ia-1/transfers/80/80/ic_check_balance.png",
                "extra": "Same day shipping"
            ], [
                "name": "Item 3",
                "price": "₹ 100",
                "image": "https://imgstatic.phonepe.com/images/dark/app-icons-ia-1/transfers/80/80/ic_check_balance.png",
                "extra": "Same day shipping"
            ], [
                "name": "Item 4",
                "price": "₹ 80",
                "image": "https://imgstatic.phonepe.com/images/dark/app-icons-ia-1/transfers/80/80/ic_check_balance.png",
                "extra": nil
            ], [
                "name": "Item 5",
                "price": "₹ 190",
                "image": "https://imgstatic.phonepe.com/images/dark/app-icons-ia-1/transfers/80/80/ic_check_balance.png",
                "extra": nil
            ], [
                "name": "Item 6",
                "price": "₹ 70",
                "image": "https://imgstatic.phonepe.com/images/dark/app-icons-ia-1/transfers/80/80/ic_check_balance.png",
                "extra": nil
            ], [
                "name": "Item 7",
                "price": "₹ 190",
                "image": "https://imgstatic.phonepe.com/images/dark/app-icons-ia-1/transfers/80/80/ic_check_balance.png",
                "extra": nil
            ], [
                "name": "Item 8",
                "price": "₹ 190",
                "image": "https://imgstatic.phonepe.com/images/dark/app-icons-ia-1/transfers/80/80/ic_check_balance.png",
                "extra": nil
            ], [
                "name": "Item 9",
                "price": "₹ 190",
                "image": "https://imgstatic.phonepe.com/images/dark/app-icons-ia-1/transfers/80/80/ic_check_balance.png",
                "extra": nil
            ]]
        ]
    ]
    
    /// Convert your hexcode to UIColor
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
