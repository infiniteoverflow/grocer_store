//
//  grocer_storeTests.swift
//  grocer_storeTests
//
//  Created by Aswin Gopinathan on 13/02/23.
//

import XCTest
@testable import grocer_store

final class grocer_storeTests: XCTestCase {
    
    var dataRepoResponse: DataWrapper<[Item]>!
    

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    // Test whether the converted hexstring color is same as the
    // given UIColor.
    func test_color_black_from_hexcode() {
        let hexcode = "000000"
        let colorAfterConversion = Utils.hexStringToUIColor(hex: hexcode)
        let expectedColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        XCTAssertEqual(colorAfterConversion, expectedColor)
    }
    
    // Test whether the converted hexstring color is same as the
    // given UIColor with the given alpha.
    func test_color_black_with_alpha_from_hexcode() {
        let hexcode = "000000"
        let colorAfterConversion = Utils.hexStringToUIColor(hex: hexcode,alpha: 0)
        let expectedColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        XCTAssertEqual(colorAfterConversion, expectedColor)
    }
    
    // Test whether the converting method is able to trim '#' from the passed
    // Hexcode string
    func test_hex_string_with_hash() {
        let hexcode = "#010204"
        let colorAfterConversion = Utils.hexStringToUIColor(hex: hexcode)
        let expectedColor = UIColor(red: 1/255, green: 2/255, blue: 4/255, alpha: 1)
        XCTAssertEqual(colorAfterConversion, expectedColor)
    }
    
    // Test the color: #5DB075
    func test_color_5DB075_from_hexcode() {
        let hexcode = "#5DB075"
        let colorAfterConversion = Utils.hexStringToUIColor(hex: hexcode)
        let expectedColor = UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1)
        XCTAssertEqual(colorAfterConversion, expectedColor)
    }
}
