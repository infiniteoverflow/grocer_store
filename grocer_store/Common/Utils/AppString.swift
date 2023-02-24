//
//  AppString.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 24/02/23.
//

import Foundation

// Strings used commonly by various sections of the app.
class AppString {
    // API Error String
    static let apiErrorString = "Something went wrong, \nPlease try again later"
    // Pull to refresh
    static let refreshText = "Pull to refresh"
    // Empty string
    static let emptyString = ""
    
    // CoreData Strings
    static let storeItemEntityName = "StoreItem"
    static let storeDataModelName = "StoreDataModel"
    
    // StoreItem Entity fields
    static let itemName = "name"
    static let itemPrice = "price"
    static let itemExtra = "extra"
    static let itemImage = "image"
}
