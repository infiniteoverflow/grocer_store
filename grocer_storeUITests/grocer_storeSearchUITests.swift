//
//  grocer_storeSearchUITests.swift
//  grocer_storeUITests
//
//  Created by Aswin Gopinathan on 23/02/23.
//

import XCTest

// This section performs the UI Testing on various aspects
// of the SearchBar on the Header of the application.
final class grocer_storeSearchUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        self.app = XCUIApplication()
        self.app.launch()
    }
    
    // Verify the SearchBar is visible on Loading the app.
    func testSearchBarVisibleOnLoad() throws {
        let searchField = XCUIApplication().searchFields["Search"]
        XCTAssertTrue(searchField.exists)
    }
    
    // Verify the SearchBar is enabled on tapping it.
    func testSearchBarOnTapIsEnabled() throws {
        let searchField = XCUIApplication().searchFields["Search"]
        searchField.tap()
        XCTAssertTrue(searchField.isEnabled)
    }
    
    // Verify the SearchBar Text is the same as we entered.
    func testSearchBarTextIsSameAsEntered() throws {
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Testing")
        XCTAssertEqual(searchField.value as! String, "Testing")
    }
    
    // Verify the SearchBar ClearText Buttonn works as expected.
    // Expected: The placeholder text "Search" should be shown.
    func testSearchBarClearTextTappedShowPlaceholderText() throws {
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Testing")
        
        searchField.buttons["Clear text"].tap()
        XCTAssertEqual(searchField.value as! String, "Search")
    }
    
    // Verify the SearchBar Search Button is visible.
    func testSearchBarSearchIsVisible() throws {
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Testing")
        
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"search\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.exists)
    }
    
    // Verify the SearchBar Search Button tapped closes the Keyboard.
    func testSearchBarSearchTappedClosesKeyboard() throws {
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Testing")
        
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"search\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertEqual(app.keyboards.count, 0)
    }
    
    // Verify the SearchBar Search Button works as expected.
    // Expected: The same text should persist in the SearchBar
    func testSearchBarSearchTappedPersistText() throws {
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Testing")
        
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"search\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertEqual(searchField.value as! String, "Testing")
    }
}
