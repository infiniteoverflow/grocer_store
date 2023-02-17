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
    private init() {}
    
    private let storeItemEntity = "StoreItem"
    
    // Clear all the values inside CoreData
    func clearLocalDataValues() async -> Bool {
        guard let appDelegate = await UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        let managedContext = await appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: storeItemEntity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(deleteRequest)
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
        
        guard let appDelegate = await UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        let managedContext = await appDelegate.persistentContainer.viewContext
        
        storeResponse.data.items.forEach {
            item in
            
            let entity = NSEntityDescription.entity(forEntityName: storeItemEntity, in: managedContext)!
            let storeItem = NSManagedObject(entity: entity, insertInto: managedContext)
            
            storeItem.setValue(item.name, forKey: "name")
            storeItem.setValue(item.price, forKey: "price")
            storeItem.setValue(item.extra, forKey: "extra")
            storeItem.setValue(item.image, forKey: "image")
        }
        
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("Cannot save to CoreData: \(error) \(error.description)")
            return false
        }
    }
    
    /// Fetch the data from CoreData
    func fetchLocalData() async -> [Item]{
        var items: [Item] = []
        guard let appDelegate =
                await UIApplication.shared.delegate as? AppDelegate else {
            return items
        }
        
        let managedContext =
        await appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
        NSFetchRequest<StoreItem>(entityName: storeItemEntity)
        
        //3
        do {
            var item = try managedContext.fetch(fetchRequest)
            item = item.sorted { a, b in
                a.name ?? "" < b.name ?? ""
            }
            
            item.forEach { itemData in
                var item = Item(
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
