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

class SendTransactionsViewModel: ViewModelType, CurrencyConverterProtocol, CountriesProtocol {
    private let disposeBag = DisposeBag()
 
    struct Input {
        let firstName: Driver<String>
        let lastName: Driver<String>
        let phoneNumber: Driver<String>
        let phoneNumberEndEditing: Driver<String>
        let amountToSendInBinaria: Driver<String>
        let binariaDidEndEditing: Driver<String>
        let sendAction: Driver<Void>
        let selectedCountry: Driver<CountryList>
    }
    
    struct Output {
        let alertTrigger: Driver<Void>
        let amountInLocalCurrency: Driver<String>
        let isValid: Driver<Bool>
        let isValidPhoneNumber: Driver<Bool>
        let isValidBinaria: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        
        let amountToSend = input.binariaDidEndEditing.asObservable()
            .flatMap { binariaAmount -> Observable<String> in
                self.exchange(Binaria: binariaAmount)
    }.asDriver(onErrorJustReturn: "")
    

        let alertTrigger = input.sendAction
        
        let isValid: Driver<Bool> = Driver.combineLatest(input.firstName, input.lastName, input.phoneNumber, input.amountToSendInBinaria).map { firstName, lastName, phone, amount -> Bool in
            return firstName.count > 0
                && lastName.count > 0
                && phone.count > 0
                && amount.count > 0
        }
        
        let isValidPhoneNumber = Driver.combineLatest(input.selectedCountry, input.phoneNumberEndEditing)
            .map({ [unowned self] country, phoneNumber -> Bool in
                let isEmpty = phoneNumber.isEmpty || phoneNumber == ""
                guard let selectedCountry = self.countries[country] else { return false}
                return !isEmpty && phoneNumber.count <= selectedCountry.maxNumberAfterPrefix
            })
        
        let isValidBinaria = input.binariaDidEndEditing
            .map{ text -> Bool in
                text.filter{ $0 != "0" && $0 != "1"}.count == 0
            }
        
        let isValidForm = Driver
            .combineLatest(isValid, isValidPhoneNumber, isValidBinaria)
            .map { $0 && $1 && $2}
            .startWith(false)
        
        return Output(alertTrigger: alertTrigger,
                      amountInLocalCurrency: amountToSend,
                      isValid: isValidForm,
                      isValidPhoneNumber: isValidPhoneNumber,
                      isValidBinaria: isValidBinaria)
    }
    
}
