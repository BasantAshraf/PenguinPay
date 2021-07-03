//
//  Int+Extension.swift
//  PenguinPay
//
//  Created by Bassant Ashraf on 02/07/2021.
//

import Foundation

extension Int {
    //From Decimal
    //10 -> "2"
    func decToBinString() -> String {
        return String(self, radix: 2, uppercase: true)
    }
}

extension Double {
    //From Decimal
    //10 -> "2"
    func decToBin() -> Double? {
        return Double(String(Int(self), radix: 2, uppercase: true))
    }
    
    func decToBinString() -> String {
        return String(Int(self), radix: 2, uppercase: true)
    }
}

extension String {
    
    //To Decimal
    //"2" -> 10
    func binToDec() -> Int {
        return Int(self, radix: 2)!
    }
    
    func binToDecDouble() -> Double {
        return Double(Int(self, radix: 2) ?? 0)
    }
    
    func trimmedLeadingZeros() -> String {
        self.replacingOccurrences(of: "^0+", with: "", options: .regularExpression)
    }
}
