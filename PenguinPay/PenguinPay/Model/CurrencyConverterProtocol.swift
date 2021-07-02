//
//  CurrencyConverterProtocol.swift
//  PenguinPay
//
//  Created by Bassant Ashraf on 02/07/2021.
//

import Foundation

protocol CurrencyConverterProtocol {
    func exchange(Binaria: String) -> String
}

extension CurrencyConverterProtocol {
    func exchange(Binaria: String) -> String {
        let usd = exchangeBinariaToUSD(Binaria: Binaria)
        let usdRate = fetchRateFromApi()
        let exchanges = usd*usdRate
        return exchanges.decToBinString()
    }
    
    func exchangeBinariaToUSD(Binaria: String) -> Double {
        Binaria.binToDecDouble()
    }
    
    func fetchRateFromApi() -> Double {
        return 361.5
    }
    
}
