//
//  item_model.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 14/02/23.
//

import Foundation

/// A Model class that store details about an Item in Store.
struct Item : Codable {
    
    /// Stores the name of the Item
    var name: String? = ""
    
    /// Stores the price of the Item
    var price: String? = ""
    
    /// Stores any additional detail about the Item
    var extra: String? = ""
    
    /// Stores the image of the Item
    var image: String? = ""
}
