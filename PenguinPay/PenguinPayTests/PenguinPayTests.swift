//
//  PenguinPayTests.swift
//  PenguinPayTests
//
//  Created by Bassant Ashraf on 02/07/2021.
//

import XCTest
@testable import PenguinPay

class ExtensionsTests: XCTestCase {
    
    func testConverter() {
        
        var decInt = 2
        var binStr = "10"
        
        //From Decimal to binary
        //"10" -> 2
        XCTAssertEqual(binStr, decInt.decToBinString())
        //binary To Decimal
        //2 -> "10"
        XCTAssertEqual(decInt, binStr.binToDec())
        
        decInt = 13511
        binStr = "11010011000111"
        
        XCTAssertEqual(binStr, decInt.decToBinString())
        XCTAssertEqual(decInt, binStr.binToDec())
    }
    
}

class CountriesProtocolTests: XCTestCase, CountriesProtocol {
    
    func testCountriesCurrency() {
        XCTAssertEqual("KES", currency(for: .kenya))
        XCTAssertEqual("NGN", currency(for: .nigeria))
        XCTAssertEqual("TZS", currency(for: .tanzania))
        XCTAssertEqual("UGX", currency(for: .uganda))
        
    }
    
}
