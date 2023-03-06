//
//  grocer_storeFilterSectionUITests.swift
//  grocer_storeUITests
//
//  Created by Aswin Gopinathan on 24/02/23.
//

import XCTest

final class grocer_storeFilterLabelUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        self.app = XCUIApplication()
        self.app.launch()
    }

    // Test Filter Label shows up on Launch
    func testFilterShowsUpOnLaunch() {
        let filterLabel = app.buttons["FilterLabel"]
        XCTAssertTrue(filterLabel.exists)
    }
}
