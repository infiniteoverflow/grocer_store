//
//  CoreDataStack.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 19/02/23.
//

import Foundation
import CoreData

/// A Stack that takes care of initializing your CoreData artefacts.
class CoreDataStack {
    
    // MARK: UI Elements
    /// UI Elements
    /// Programmatic representation of Model file
    static let model: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: AppString.storeDataModelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    // MARK: Methods
    /// Methods
    /// Save your Context
    private func saveContext(_ context: NSManagedObjectContext) {
        context.perform {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    /// A container that encapsulates the Core Data stack in your app.
    var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: AppString.storeDataModelName, managedObjectModel: model)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    /// Get the main context of your NSPersistentContainer
    func getMainContext() -> NSManagedObjectContext {
        return storeContainer.viewContext
    }
    
    /// Save your Context
    public func saveContext() {
        saveContext(getMainContext())
    }
}
