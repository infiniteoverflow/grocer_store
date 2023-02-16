//
//  ViewModel.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 14/02/23.
//

import Foundation

class ViewModel : ObservableObject {
    @Published var store: DataWrapper<StoreResponse> = DataWrapper()
    
    func getStoreDetails() async throws {
        store.isLoading = true
  
        let storeResponse = try await ApiService().getStoreData()
        
        if(storeResponse == nil) {
            store.error = "No Data Found"
        } else {
            store.success = storeResponse
        }
        
        store.isLoading = false
        
    }
}
