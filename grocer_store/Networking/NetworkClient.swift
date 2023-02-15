//
//  network_client.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 14/02/23.
//

import Foundation

/// A Network Client that performs all the tasks related
/// to network calls.
struct NetworkClient {
    // create a singleton
    static let instance = NetworkClient()

    // create a private initializer
    private init() {}
    
    // the shared URLSession instance
    private let session = URLSession.shared
    
    /// performs the network call
    func call(url using: String) async throws -> Data {
        
        // URL object for performing the network request
        let url = URL(string: using)!
        
        // Perform the network request
        let (data,_) = try await URLSession.shared.data(from: url)
        
        return data
    }
}
