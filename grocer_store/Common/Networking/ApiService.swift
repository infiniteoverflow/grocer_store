//
//  api_service.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 14/02/23.
//

import Foundation

struct ApiService {
    
    /// Get the Store Data from the API
    /// `handler` : Works as a completion handler to return the API Response back to its caller.
    func getStoreData(_ handler: (_ storeResponse: StoreResponse?) -> Void) async {
        let data = await NetworkClient.instance.call(url: URLConstants.getStoreData)
        var storeModel: StoreResponse
        
        // if data is nil, then use the mock data
        if(data == nil) {
            handler(nil)
        }
        
        do {
            storeModel = try JSONDecoder().decode(StoreResponse.self, from: data!)
            handler(storeModel)
        } catch {
            handler(nil)
        }
    }
}
