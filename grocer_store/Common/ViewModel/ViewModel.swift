//
//  ViewModel.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 14/02/23.
//

import Foundation

class ViewModel : ObservableObject {
    @Published var store: DataWrapper<StoreResponse> = DataWrapper()
    
    /// Get the store details from the API or Mock Data
    func getStoreDetails() async throws {
        store.isLoading = true

        let storeResponse = try await ApiService().getStoreData()
        
        if(storeResponse == nil) {
            store.error = "No Data Found"
        } else {
            store.success = storeResponse
            let isStored = await LocalDataHelper.instance.storeLocalData(storeResponse: storeResponse!)
            let fetchedData = await LocalDataHelper.instance.fetchLocalData()
        }
        
        store.isLoading = false
        
    }
}
