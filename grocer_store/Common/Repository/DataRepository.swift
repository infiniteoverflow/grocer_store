//
//  DataRepository.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 17/02/23.
//

import Foundation

/// A Repository that connects the Data source with the ViewModel
class DataRepository {
    
    var coreDataHelper: CoreDataHelper = CoreDataHelper(coreDataStack: CoreDataStack())
    
    /// Fetch store details from the API or CoreData if the API fails
    func fetchStoreDetails() async -> DataWrapper<[Item]> {
        /// The result of the fetch process
        var response = DataWrapper<[Item]>()
        
        let storeResponse = await ApiService().getStoreData()
        
        if storeResponse == nil {
            let items: [Item] = coreDataHelper
                .fetchLocalData()
            
            if items.count == 0 {
                response.error = "No Data Found"
            } else {
                response.success = items
            }
            
            return response
        }
        
        let _ = await coreDataHelper.storeLocalData(storeResponse: storeResponse!)
        
        response.success = storeResponse!.data.items
        return response
    }
}
