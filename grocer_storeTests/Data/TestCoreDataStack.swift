//
//  grocer_testCoreDataStack.swift
//  grocer_storeTests
//
//  Created by Aswin Gopinathan on 18/02/23.
//

import CoreData
import grocer_store

/// Mocking the CoreDataStack to make it suitable for Unit-testing.
class TestCoreDataStack: CoreDataStack {
    func setupCoreDataHelper() {
        let peristentStoreDescription = NSPersistentStoreDescription()
        peristentStoreDescription.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(
            name: AppString.storeDataModelName,
            managedObjectModel: CoreDataStack.model
        )
        
        container.persistentStoreDescriptions = [peristentStoreDescription]
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        storeContainer = container
    }
}
