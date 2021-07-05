//
//  SendTransactionsViewModel.swift
//  PenguinPay
//
//  Created by Bassant Ashraf on 02/07/2021.
//

import Foundation
import RxCocoa
import RxSwift

struct FormOfReceipient {
    let firstName: String
    let lastName: String
    let phoneNumber: String
    let country: CountryList
    let amountToSendInBinaria: String
}

class SendTransactionsViewModel: CurrencyConverterProtocol, CountriesProtocol {
    private let disposeBag = DisposeBag()
    
    
}

extension SendTransactionsViewModel: ViewModelType {
    
    struct Input {
        let firstName: Driver<String>
        let lastName: Driver<String>
        let phoneNumber: Driver<String>
        let amountToSendInBinaria: Driver<String>
        let sendAction: Driver<Void>
        let selectedCountry: Driver<CountryList>
    }
    
    struct Output {
        //        let fetching: Driver<Bool>
        let alertTrigger: Driver<Void>
        let amountInLocalCurrency: Driver<String>
        let isValid: Driver<Bool>
        let isValidPhoneNumber: Driver<Bool>
        //        let error: Driver<Error>
    }
    
    func transform(input: Input) -> Output {
        
        let amountToSend = input.amountToSendInBinaria.map{ self.exchange(Binaria: $0)}
        let alertTrigger = Driver.merge(input.sendAction, amountToSend.map{_ in })

        let isValid: Driver<Bool> = Driver.combineLatest(input.firstName, input.lastName, input.phoneNumber, input.amountToSendInBinaria).map { firstName, lastName, phone, amount -> Bool in
            return firstName.count > 0
                && lastName.count > 0
                && phone.count > 0
                && amount.count > 0
        }
        
       let isValidPhoneNumber = Driver.combineLatest(input.selectedCountry, input.phoneNumber)
            .map({ [unowned self] country, phoneNumber -> Bool in
                if phoneNumber.isEmpty || phoneNumber == "" { return true}
                guard let selectedCountry = self.countries[country] else { return false}
                return phoneNumber.count <= selectedCountry.maxNumberAfterPrefix
            })
        return Output(alertTrigger: alertTrigger,
                      amountInLocalCurrency: amountToSend,
                      isValid: isValid,
                      isValidPhoneNumber: isValidPhoneNumber)
    }
    
}
