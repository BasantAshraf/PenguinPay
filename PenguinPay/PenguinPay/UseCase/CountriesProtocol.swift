//
//  CountriesProtocol.swift
//  PenguinPay
//
//  Created by Bassant Ashraf on 02/07/2021.
//

import Foundation

protocol CountriesProtocol {
    var countries: [CountryList: Country] { get}
    func currency(for country: CountryList) -> String?
    var defaultCountry: CountryList { get}
}

extension CountriesProtocol {
    var countries: [CountryList: Country] {
        let kenya = Country(name: "Kenya",
                            currency: "KES",
                            flag: "π°πͺ",
                            phonePrefix: 254,
                            maxNumberAfterPrefix: 9)
        let nigeria = Country(name: "Nigeria",
                              currency: "NGN",
                              flag: "π³π¬",
                              phonePrefix: 234,
                              maxNumberAfterPrefix: 7)
        let tanzania = Country(name: "Tanzania",
                               currency: "TZS",
                               flag: "πΉπΏ",
                               phonePrefix: 255,
                               maxNumberAfterPrefix: 9)
        let uganda = Country(name: "Uganda",
                             currency: "UGX",
                             flag: "πΊπ¬",
                             phonePrefix: 256,
                             maxNumberAfterPrefix: 7)
        return [.nigeria: nigeria,
                .kenya: kenya,
                .tanzania: tanzania,
                .uganda: uganda]
    }
    
    func currency(for country: CountryList) -> String? {
        countries[country]?.currency
    }
    
    var defaultCountry: CountryList {
        .nigeria
    }

}
