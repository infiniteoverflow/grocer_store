//
//  ViewModel.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 14/02/23.
//

import Foundation

/// Connects your view with your model artefacts
class ViewModel {
    
    // Making this class a Singleton.
    static let instance = ViewModel()
    private init() {}
        
    /// Get the store details from the API or Mock Data.
    func getStoreDetails() async {
        
        // Notify the given subscribers that the network fetch process is going on.
        Publisher.instance.notify(
            list: ["ProductListingTableView","ProductListingCollectionView"],
            state: .loading,
            extra: nil
        )
        
        await DataRepository().fetchStoreDetails{ result in
            if(result.error != AppString.emptyString) {
                
                // Notify the given subscribers that the network fetch failed.
                Publisher.instance.notify(
                    list: ["ProductListingTableView","ProductListingCollectionView"],
                    state: .failure,
                    extra: "Something went wrong"
                )
            } else {
                
                // Notify the given subscribers that the network fetch succeeded, and pass
                // the api response.
                Publisher.instance.notify(
                    list: ["ProductListingTableView","ProductListingCollectionView"],
                    state: .success,
                    extra: result.success
                )
            }
        }
    }
}
