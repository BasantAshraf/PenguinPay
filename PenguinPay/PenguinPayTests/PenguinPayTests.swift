//
//  PenguinPayTests.swift
//  PenguinPayTests
//
//  Created by Bassant Ashraf on 02/07/2021.
//

import XCTest
@testable import PenguinPay

class ExtensionsTests: XCTestCase, CurrencyConverterProtocol {
    
    func testConverter() {
        
        var decInt = 2
        var binStr = "10"
        var decDouble: Double = 2.0
        
        //From Decimal to binary
        //"10" -> 2
        XCTAssertEqual(binStr, decInt.decToBinString())
        //binary To Decimal
        //2 -> "10"
        XCTAssertEqual(decInt, binStr.binToDec())
        XCTAssertEqual(binStr, decDouble.decToBinString())

        decInt = 22
        binStr = "010110"
        decDouble = 22.0

        
        XCTAssertEqual(binStr.trimmedLeadingZeros(), decInt.decToBinString())
        XCTAssertEqual(decInt, binStr.binToDec())
        XCTAssertEqual(binStr.trimmedLeadingZeros(), decDouble.decToBinString())
        XCTAssertEqual("01111100010001".trimmedLeadingZeros(), exchange(Binaria: binStr))
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
