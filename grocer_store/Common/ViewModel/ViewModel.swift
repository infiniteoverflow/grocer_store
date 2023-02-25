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
        Publisher.instance.notify(
            list: ["ProductListingTableView","ProductListingCollectionView"],
            state: .loading,
            extra: nil
        )

        let result = await DataRepository().fetchStoreDetails()
        
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
