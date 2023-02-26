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
        
    /// Get the store details from the API or Mock Data
    func getStoreDetails() async {
        Publisher.instance.notify(
            list: ["ProductListingTableView","ProductListingCollectionView"],
            state: .loading,
            extra: nil
        )
        
        await DataRepository().fetchStoreDetails{ result in
            if(result.error != AppString.emptyString) {
                Publisher.instance.notify(
                    list: ["ProductListingTableView","ProductListingCollectionView"],
                    state: .failure,
                    extra: "Something went wrong"
                )
            } else {
                Publisher.instance.notify(
                    list: ["ProductListingTableView","ProductListingCollectionView"],
                    state: .success,
                    extra: result.success
                )
            }
        }
    }
}
