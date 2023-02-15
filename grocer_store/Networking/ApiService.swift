//
//  api_service.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 14/02/23.
//

import Foundation

struct ApiService {
    
    // Get the Store Data from the API
    func getStoreData() async throws -> StoreResponse{
        let data = try await NetworkClient.instance.call(url: URLConstants.getStoreData)
        
        let storeModel: StoreResponse = try JSONDecoder().decode(StoreResponse.self, from: data)
        
        print(storeModel.data.items)
        
        return storeModel
    }
}
