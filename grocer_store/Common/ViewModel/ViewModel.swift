//
//  ViewModel.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 14/02/23.
//

import Foundation

/// Connects your view with your model artefacts
class ViewModel : ObservableObject {
    
    // Making this class a Singleton.
    static let instance = ViewModel()
    private init() {}
    
    @Published var store: DataWrapper<[Item]> = DataWrapper()
    
    /// Get the store details from the API or Mock Data
    func getStoreDetails() async {
        store.isLoading = true

        let result = await DataRepository().fetchStoreDetails()
        
        if(result.error != "") {
            print("Error")
            store.error = "No Data Found"
        } else {
            print("Response")
            store.error = ""
            store.success = result.success
        }
        
        store.isLoading = false
        
    }
}
