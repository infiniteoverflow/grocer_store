//
//  grocer_storeFilterUITests.swift
//  grocer_storeUITests
//
//  Created by Aswin Gopinathan on 05/03/23.
//

import XCTest

final class grocer_storeFilterUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        self.app = XCUIApplication()
        self.app.launch()
    }
    
    // Verify Filter is Clickable and Popover View opens.
    func testFilterIsClickable() {
        let filter = app.buttons["FilterLabel"]
        filter.tap()
        
        let popOverView = app.otherElements["AppFilterViewController"]
        XCTAssertTrue(popOverView.exists)
    }
}
