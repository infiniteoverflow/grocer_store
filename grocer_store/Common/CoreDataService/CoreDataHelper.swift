//
//  LocalDataHelper.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 17/02/23.
//

import CoreData
import UIKit

/// A Helper class for performing all your CoreData Actions.
class CoreDataHelper {
    
    // MARK: Lifecycle methods
    /// Lifecycle methods
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.getMainContext()
    }
    
    // MARK: Properties
    /// Properties
    private let storeItemEntity = "StoreItem"
    private let managedObjectContext: NSManagedObjectContext
    private let coreDataStack: CoreDataStack
    
    // MARK: View Methods
    /// View Methods
    /// Clear all the values inside CoreData
    func clearLocalDataValues() async -> Bool {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: storeItemEntity)
        let deleteRequest: NSBatchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            // For NSInMemoryStoreType, deleteRequest cannot be executed.
            if coreDataStack.storeContainer.persistentStoreDescriptions.first?.type == NSInMemoryStoreType {
                managedObjectContext.reset()
            }
            else {
                try managedObjectContext.execute(deleteRequest)
            }
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
    func fetchLocalData() -> [Item]{
        var items: [Item] = []
        
        let fetchRequest =
        NSFetchRequest<StoreItem>(entityName: storeItemEntity)
        
        do {
            var item = try managedObjectContext.fetch(fetchRequest) as NSArray
            item = item.sorted(by: {
                itemA, itemB in
                (itemA as! StoreItem).name ?? "" < (itemB as! StoreItem).name ?? ""
            }) as NSArray
            
            item.forEach { itemData in
                let item = Item(
                    name: (itemData as? StoreItem)?.name ?? "",
                    price: (itemData as? StoreItem)?.price ?? "",
                    extra: (itemData as? StoreItem)?.extra ?? "",
                    image: (itemData as? StoreItem)?.image ?? ""
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
