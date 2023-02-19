//
//  LocalDataHelper.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 17/02/23.
//

import CoreData
import UIKit

class LocalDataHelper {
    // create a singleton
    static let instance = LocalDataHelper()
    
    // create a private initializer
    private init() {
        self.coreDataStack = CoreDataStack()
        self.managedObjectContext = coreDataStack.getMainContext()
    }
    
    private let storeItemEntity = "StoreItem"
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    // Clear all the values inside CoreData
    func clearLocalDataValues() async -> Bool {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: storeItemEntity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedObjectContext.execute(deleteRequest)
            return true
        } catch let error as NSError {
            print("Cannot delete CoreData Entities: \(error) \(error.description)")
            return false
        }
    }
    
    /// Store API Data into CoreData
    func storeLocalData(storeResponse: StoreResponse) async -> Bool{
        
        let isDeleted = await clearLocalDataValues()
        if !isDeleted {
            return false
        }

        
        storeResponse.data.items.forEach {
            item in
            
            let entity = NSEntityDescription.entity(forEntityName: storeItemEntity, in: managedObjectContext)!
            let storeItem = NSManagedObject(entity: entity, insertInto: managedObjectContext)
            
            storeItem.setValue(item.name, forKey: "name")
            storeItem.setValue(item.price, forKey: "price")
            storeItem.setValue(item.extra, forKey: "extra")
            storeItem.setValue(item.image, forKey: "image")
        }
        
        do {
            try managedObjectContext.save()
            return true
        } catch let error as NSError {
            print("Cannot save to CoreData: \(error) \(error.description)")
            return false
        }
    }
    
    /// Fetch the data from CoreData
    func fetchLocalData() async -> [Item]{
        var items: [Item] = []
        
        //2
        let fetchRequest =
        NSFetchRequest<StoreItem>(entityName: storeItemEntity)
        
        //3
        do {
            var item = try managedObjectContext.fetch(fetchRequest)
            item = item.sorted { a, b in
                a.name ?? "" < b.name ?? ""
            }
            
            item.forEach { itemData in
                let item = Item(
                    name: itemData.name ?? "", price: itemData.price ?? "", extra: itemData.extra, image: itemData.image
                )
                
                items.append(item)
            }
            
            return items
        } catch let error as NSError {
            print("Couldnt fetch records: \(error) \(error.description)")
            return items
        }
    }
}
