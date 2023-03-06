//
//  grocer_storeCollectionViewUITests.swift
//  grocer_storeUITests
//
//  Created by Aswin Gopinathan on 06/03/23.
//

import XCTest

final class grocer_storeMenuViewUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        self.app = XCUIApplication()
        self.app.launch()
    }
    
    // Verify Menu icon is visible on load
    func testMenuIconIsVisible() {
        let menu = app.images["MenuIcon"]
        XCTAssertTrue(menu.exists)
    }
    
    // Verify On Tapping Menu Icon from the TableView,
    // the Menu View opens.
    func testMenuTapFromTVOpensView() {
        let menu = app.images["MenuIcon"]
        XCTAssertTrue(menu.exists)
        menu.tap()
        
        let menuVC = app.otherElements["MenuViewController"]
        let _ = menuVC.waitForExistence(timeout: 2)
        
        XCTAssertTrue(menuVC.exists)
    }
    
    // Verify On Tapping Menu Icon from the CollectionView, the
    // Menu View opens.
    func testMenuTapFromCVOpensView() {
        let menu = app.images["MenuIcon"]
        let collectionView = app.collectionViews["MainCollectionView"]
        let tableView = app.tables["MainTableView"]
        
        XCTAssertTrue(tableView.waitForExistence(timeout: 4))
                
        tableView.swipeLeft()
        
        XCTAssertTrue(collectionView.waitForExistence(timeout: 2))
        
        XCTAssertTrue(menu.exists)
        menu.tap()
        
        let menuVC = app.otherElements["MenuViewController"]
        let _ = menuVC.waitForExistence(timeout: 2)
        
        XCTAssertTrue(menuVC.exists)
    }
    
    // Verify Header section of the Menu View is visible
    func testHeaderOfMenuView() {
        let menu = app.images["MenuIcon"]
        XCTAssertTrue(menu.exists)
        menu.tap()
        
        let menuVC = app.otherElements["MenuViewController"]
        let _ = menuVC.waitForExistence(timeout: 2)
        
        XCTAssertTrue(menuVC.exists)
    }
}
