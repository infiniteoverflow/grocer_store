//
//  ViewModel.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 14/02/23.
//

import Foundation

/// Connects your view with your model artefacts
class ViewModel {
    
    // Store the instance of the NetworkDelegate for
    // passing the api status to the Views Conformed to it.
    var networkDelegate: NetworkDelegate!
        
    /// Get the store details from the API or Mock Data.
    func getStoreDetails() async {
        
        // Notify the given subscribers that the network fetch process is going on.
        self.networkDelegate.updateViewWithData(state: .loading, extra: nil)
        
        await DataRepository().fetchStoreDetails{ result in
            if(result.error != AppString.emptyString) {
                
                // Notify the given subscribers that the network fetch failed.
                self.networkDelegate.updateViewWithData(state: .failure, extra: "Something went wrong")
            } else {
                // Notify the given subscribers that the network fetch succeeded, and pass
                // the api response.
                self.networkDelegate.updateViewWithData(state: .success, extra: result.success)
            }
        }
    }
}
