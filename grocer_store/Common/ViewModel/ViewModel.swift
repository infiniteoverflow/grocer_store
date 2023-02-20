//
//  ViewModel.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 14/02/23.
//

import Foundation

/// Connects your view with your model artefacts
class ViewModel : ObservableObject {
    @Published var store: DataWrapper<[Item]> = DataWrapper()
    
    /// Get the store details from the API or Mock Data
    func getStoreDetails() async {
        store.isLoading = true

        let result = await DataRepository().fetchStoreDetails()
        
        if(result.error != "") {
            store.error = "No Data Found"
        } else {
            store.success = result.success
        }
        
        store.isLoading = false
        
    }
}
