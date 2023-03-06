//
//  grocer_storeItemDetailsUITests.swift
//  grocer_storeUITests
//
//  Created by Aswin Gopinathan on 05/03/23.
//

import XCTest

final class grocer_storeItemDetailsUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        self.app = XCUIApplication()
        self.app.launch()
    }
    
    // Verify the screen opens from the table view
    func testItemDetailsScreenOpensFromTableView() {
        let tableView = app.tables["MainTableView"]
                
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: tableView)
        
        waitForExpectations(timeout: 5)
        
        if tableView.cells.count > 0 {
            tableView.cells["Item 1"].tap()
            
            XCTAssertTrue(app.images["ItemImage"].exists)
            XCTAssertTrue(app.staticTexts["ItemName"].exists)
            XCTAssertTrue(app.staticTexts["ItemPrice"].exists)
            XCTAssertTrue(app.staticTexts["ExtraLabel"].exists)
            XCTAssertTrue(app.staticTexts["MRPLabel"].exists)
        } else {
            XCTAssertTrue(tableView.exists)
        }
    }
}
