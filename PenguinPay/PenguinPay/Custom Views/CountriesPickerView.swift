//
//  CountriesPickerView.swift
//  PenguinPay
//
//  Created by Bassant Ashraf on 05/07/2021.
//

import UIKit
import RxSwift
import RxCocoa

class CountriesPickerView: UIPickerView, CountriesProtocol {
    
    let countries: [CountryList] = [.nigeria, .kenya, .tanzania, .uganda]
    var selectedRow = BehaviorRelay<CountryList>(value: .nigeria) // default value inside pickerView
    
    let disposeBag = DisposeBag()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setup()
    }
    
    func setup() {
        _ = Observable.of(countries)
            .bind(to: self.rx.itemTitles) { row, element in
                guard let country = self.countries[element] else { return nil }
                return country.flagWithCode
            }.disposed(by: disposeBag)

        // did select country code
       _ = self.rx.itemSelected
        .subscribe(onNext: { [weak self] row, component in
            guard let self = self else { return }
            self.selectedRow.accept(  self.countries[row])
        }).disposed(by: disposeBag)
        
    }
    
}
