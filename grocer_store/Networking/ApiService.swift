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
        var data = await NetworkClient.instance.call(url: URLConstants.getStoreData)
        var storeModel: StoreResponse
        
        // if data is nil, then use the mock data
        if(data == nil) {
            let jsonData = try JSONSerialization.data(withJSONObject: Utils.mockData, options: .prettyPrinted)
            data = jsonData
        }
        
        storeModel = try JSONDecoder().decode(StoreResponse.self, from: data!)
        
        print(storeModel.data.items)
        
        return storeModel
    }
}
