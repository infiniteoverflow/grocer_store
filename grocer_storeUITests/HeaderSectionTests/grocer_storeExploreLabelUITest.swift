//
//  grocer_storeExploreLabelUITest.swift
//  grocer_storeUITests
//
//  Created by Aswin Gopinathan on 24/02/23.
//

import XCTest

final class grocer_storeExploreLabelUITest: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        self.app = XCUIApplication()
        self.app.launch()
    }

    // Test Filter Label shows up on Launch
    func testFilterShowsUpOnLaunch() {
        let exploreLabel = app.staticTexts.element(matching: .any, identifier: "Explore")
        XCTAssertTrue(exploreLabel.exists)
    }
}
