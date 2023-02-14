//
//  store_model.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 14/02/23.
//

import Foundation

struct StoreModel {
    let status: String
    let error: String
    let items: [ItemModel]
    
    init(status: String, error: String, items: [ItemModel]) {
        self.status = status
        self.error = error
        self.items = items
    }
}
