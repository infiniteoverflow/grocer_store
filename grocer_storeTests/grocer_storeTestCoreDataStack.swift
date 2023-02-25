//
//  grocer_storeTestCoreDataStack.swift
//  grocer_storeTests
//
//  Created by Aswin Gopinathan on 19/02/23.
//

import XCTest

final class grocer_storeTestCoreDataStack: XCTestCase {
    
    /// Class that contains all the operations related to CoreData.
    var coreDataHelper: CoreDataHelper!
    
    /// Initialises the CoreData Artefacts
    var coreDataStack: TestCoreDataStack!

    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        coreDataStack.setupCoreDataHelper()
        coreDataHelper = CoreDataHelper(coreDataStack: coreDataStack)
    }

    /// Test Adding a new item to CoreData
    func testAddStoreItemToCoreData() async throws {
        let context = coreDataStack.getMainContext()
        
        expectation(forNotification: .NSManagedObjectContextDidSave, object: coreDataStack.getMainContext()) {
            _ in return true
        }
        
        await context.perform {
            let storeResponse = StoreResponse(
                status: "success",
                error: nil,
                data: StoreData(
                    items: [
                        Item(name: "Item 1", price: "100", extra: "Same day shipping", image: nil)
                    ]
                )
            )
            
            Task {
                await self.coreDataHelper.storeLocalData(storeResponse: storeResponse)
            }
        }
        
        await waitForExpectations(timeout: 2.0) {
            error in
            XCTAssertNil(error,"Save did not occur")
        }
    }
    
    /// Test whether the added item is available in CoreData
    func testGetStoreItemsFromCoreData() async{
        let context = coreDataStack.getMainContext()
        
        await context.perform {
            let storeResponse = StoreResponse(
                status: "success",
                error: nil,
                data: StoreData(
                    items: [
                        Item(name: "Item 1", price: "100", extra: "Same day shipping", image: nil)
                    ]
                )
            )
            
            Task {
                let _ = await self.coreDataHelper.storeLocalData(storeResponse: storeResponse)
                let getItems = self.coreDataHelper.fetchLocalData()
                XCTAssertEqual(getItems.count, 1)
            }
        }
    }
    
    /// Test the Clear CoreData operation.
    func testClearCoreData() async {
        let cleared = await coreDataHelper.clearLocalDataValues()
        
        XCTAssertTrue(cleared)
        
        let getItems = coreDataHelper.fetchLocalData()
        XCTAssertEqual(getItems.count, 0)
    }

}
