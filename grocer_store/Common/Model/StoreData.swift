//
//  store_data.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 14/02/23.
//

import Foundation

/// Contains all information about the store
struct StoreData: Codable {
    
    // List of items in the store
    var items: [Item]
}
