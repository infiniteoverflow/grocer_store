//
//  store_model.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 14/02/23.
//

import Foundation


/// A Model class to store the response of the API along with its status and error
/// information if any.
struct StoreResponse: Codable {
    
    /// Gives the status of the API querying.
    let status: String
    
    /// Gives information about any error that failed the API querying.
    let error: String?
    
    /// Store Data returned by the API response
    let data: StoreData
}
