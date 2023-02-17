//
//  api_service.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 14/02/23.
//

import Foundation

struct ApiService {
    
    // Get the Store Data from the API
    func getStoreData() async throws -> StoreResponse? {
        let data = await NetworkClient.instance.call(url: URLConstants.getStoreData)
        var storeModel: StoreResponse
        
        // if data is nil, then use the mock data
        if(data == nil) {
            return nil
        }
        
        do {
            storeModel = try JSONDecoder().decode(StoreResponse.self, from: data!)
            return storeModel
        } catch {
            return nil
        }
    }
}
