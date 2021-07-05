//
//  CountryModel.swift
//  PenguinPay
//
//  Created by Bassant Ashraf on 02/07/2021.
//

import Foundation

enum CountryList: CaseIterable {
    case kenya
    case nigeria
    case tanzania
    case uganda
}

struct Country {
    var name: String
    var currency: String
    var flag: String
    var phonePrefix: Int
    var maxNumberAfterPrefix: Int
    
    var flagWithCode: String {
        "\(flag)    +\(phonePrefix)"
    }
}
