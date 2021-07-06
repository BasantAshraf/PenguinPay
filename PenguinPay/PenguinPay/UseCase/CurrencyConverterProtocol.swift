//
//  CurrencyConverterProtocol.swift
//  PenguinPay
//
//  Created by Bassant Ashraf on 02/07/2021.
//

import Foundation
import RxSwift

protocol CurrencyConverterProtocol {
  //  010110 Binaria  ⇒ 22 USD ⇒    1 USD = 361.50 ⇒ (22 * 361.5 = 7953) ⇒  01111100010001 USD.
    func exchange(Binaria: String, countryCode: String) -> Observable<String>
    func testExchange(Binaria: String) -> String
}

extension CurrencyConverterProtocol {
    func exchange(Binaria: String, countryCode: String) -> Observable<String> {
        FetchExchangeRatesUseCase()
            .fetch()
            .map { exchanges in
                let usd = exchangeBinariaToUSD(Binaria: Binaria)
                guard let usdEquivalentRate = exchanges.rates[countryCode] else { return "country code not found"}
                print("rate is \(String(describing: usdEquivalentRate))")
                let amountToSend = (usdEquivalentRate * usd).decToBinString()
                return " 1 usd = \(usdEquivalentRate.decToBinString()) \n you will send \(amountToSend) Binaria "
            }
    }
    
    func exchangeBinariaToUSD(Binaria: String) -> Double {
        Binaria.binToDecDouble()
    }
 
}

extension CurrencyConverterProtocol {
    func testExchange(Binaria: String) -> String {
        let usd = exchangeBinariaToUSD(Binaria: Binaria)
        let usdRate = testFetchRateFromApi()
        let exchanges = usd*usdRate
        return exchanges.decToBinString()
    }

    func testFetchRateFromApi() -> Double {
        return 361.5
    }
}
