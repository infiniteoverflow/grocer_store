//
//  DataRepository.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 17/02/23.
//

import Foundation

/// A Repository that connects the Data source with the ViewModel
class DataRepository {
    
    // MARK: Properties
    /// Instance to the CoreDataHelper class that takes care of your CoreData functionalities.
    var coreDataHelper: CoreDataHelper = CoreDataHelper(coreDataStack: CoreDataStack())
    
    // MARK: Methods
    /// Fetch store details from the API or CoreData if the API fails
    /// `handler` : Works as a completion handler to return the API Response back to its caller.
    func fetchStoreDetails(_ handler: (_ data: DataWrapper<[Item]>) -> Void) async {
        /// The result of the fetch process
        var response = DataWrapper<[Item]>()
        
        await ApiService().getStoreData { storeResponse in
            if storeResponse == nil {
                let items: [Item] = coreDataHelper
                    .fetchLocalData()
                
                if items.count == 0 {
                    response.error = "No Data Found"
                } else {
                    response.success = items
                }
                
                handler(response)
            }
            
            // Store the API Response to the CoreData Entity.
            let _ = coreDataHelper.storeLocalData(storeResponse: storeResponse!)
            
            response.success = storeResponse!.data.items
            handler(response)
        }

    }
}
