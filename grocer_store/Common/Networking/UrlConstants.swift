//
//  url_constants.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 14/02/23.
//

import Foundation

/// Contains String constants for performing URL requests
struct URLConstants {
    /// BaseURL for the api.
    static let baseUrl = "https://run.mocky.io/"
    
    /// Gets the list of store items.
    static let getStoreData = "\(baseUrl)v3/995ce2a0-1daf-4993-915f-8c198f3f752c"
}
