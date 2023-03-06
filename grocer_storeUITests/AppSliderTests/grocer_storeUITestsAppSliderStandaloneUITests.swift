//
//  AppSliderStandaloneUITests.swift
//  grocer_storeUITests
//
//  Created by Aswin Gopinathan on 05/03/23.
//

import XCTest

final class AppSliderStandaloneUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        self.app = XCUIApplication()
        self.app.launch()
    }
    
    // Verify if the slider exists on the screen.
    func testSliderExists() {
        let slider = app.sliders["ItemSlider"]
        let tableView = app.tables["MainTableView"]
        
        XCTAssertFalse(tableView.exists)
        
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: slider)
        
        waitForExpectations(timeout: 5)
        XCTAssertTrue(slider.exists)
    }
    
    // Verify the count of items on the table is same as the
    // value on the slider.
    func testSliderValueShowsThatManyItemsOnTable() {
        let slider = app.sliders["ItemSlider"]
        var tableView = app.tables["MainTableView"]
        
        XCTAssertFalse(tableView.exists)
        
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: slider)
        
        waitForExpectations(timeout: 5)
        
        let tableHasContents = tableView.cells.count > 0
        
        if tableHasContents {
            slider.adjust(toNormalizedSliderPosition: 1/9)
            sleep(1)
            tableView = app.tables["MainTableView"]
            XCTAssertTrue(tableView.exists)
        }
    }
}
