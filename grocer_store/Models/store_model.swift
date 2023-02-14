//
//  store_model.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 14/02/23.
//

import Foundation


/// A Model class to store the response of the API along with its status and error
/// information if any.
struct StoreModel {
    
    /// Gives the status of the API querying.
    let status: String
    
    /// Gives information about any error that failed the API querying.
    let error: String?
    
    /// List of items in the store.
    let items: [ItemModel]
    
    init(status: String, error: String?, items: [ItemModel]) {
        self.status = status
        self.error = error
        self.items = items
    }
}
