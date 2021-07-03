//
//  CountryModel.swift
//  PenguinPay
//
//  Created by Bassant Ashraf on 02/07/2021.
//

import Foundation

enum CountryList {
    case kenya
    case nigeria
    case tanzania
    case uganda
    
    var flag: String {
        switch self {
        case .kenya:
            return "🇰🇪"
        case .nigeria:
            return "🇳🇬"
        case .tanzania:
            return "🇹🇿"
        case .uganda:
            return "🇺🇬"
        }
    }
}

struct Country {
    var name: String
    var currency: String
    var phonePrefix: Int
    var maxNumberAfterPrefix: Int
}
