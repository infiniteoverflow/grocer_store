//
//  grocer_storeFilterUITests.swift
//  grocer_storeUITests
//
//  Created by Aswin Gopinathan on 05/03/23.
//

import XCTest

final class grocer_storeCollectionViewUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        self.app = XCUIApplication()
        self.app.launch()
    }
    
    // Verify Collection View is visible after swiping
    func testCollectionViewIsVisibleOnSwipe() {
        let collectionView = app.collectionViews["MainCollectionView"]
        let tableView = app.tables["MainTableView"]
        
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: tableView)
        
        waitForExpectations(timeout: 5)
        
        tableView.swipeLeft()
        
        XCTAssertTrue(collectionView.waitForExistence(timeout: 2))
        
        if collectionView.cells.count > 0 {
            XCTAssertTrue(collectionView.cells["Item 1"].exists)
        } else {
            XCTAssertTrue(collectionView.exists)
        }
        
    }
}
