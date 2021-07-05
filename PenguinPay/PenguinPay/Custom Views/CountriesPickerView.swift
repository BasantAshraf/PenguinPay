//
//  CountriesPickerView.swift
//  PenguinPay
//
//  Created by Bassant Ashraf on 05/07/2021.
//

import UIKit
import RxSwift

class CountriesPickerView: UIPickerView, CountriesProtocol {
    
    let countries: [CountryList] = CountryList.allCases
    var selectedRow: Observable<CountryList>?
    
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
        
        selectedRow = self.rx.itemSelected
            .map{ selected in self.countries[selected.row]}

    }
    
}
