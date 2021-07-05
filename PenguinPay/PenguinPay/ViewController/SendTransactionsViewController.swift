//
//  SendTransactionsViewController.swift
//  PenguinPay
//
//  Created by Bassant Ashraf on 02/07/2021.
//

import UIKit
import RxSwift
import RxCocoa

class SendTransactionsViewController: UIViewController, CountriesProtocol {
    
    let pickerView =  CountriesPickerView()

    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstNameTextField: CustomTextField!
    @IBOutlet weak var lastNameTextField: CustomTextField!
    @IBOutlet weak var countryCodeTextField: CustomTextField!
    @IBOutlet weak var phoneTextField: CustomTextField!
    @IBOutlet weak var amountInBinariaToSendTextField: CustomTextField!
    @IBOutlet weak var amountInLocalCurrencyLabel: UILabel!
    
    let viewModel = SendTransactionsViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupPickerView()
        bindViewModel()
    }
    
    func setupView() {
        firstNameTextField.placeholder = "First Name"
        lastNameTextField.placeholder = "Last Name"
        phoneTextField.placeholder = "Phone"
        amountInBinariaToSendTextField.placeholder = "amount In Binaria"

        countryCodeTextField.textAlignment = .center
        sendButton.layer.cornerRadius = 15
        view.backgroundColor = Pallette.color1
        titleLabel.textColor = Pallette.color2
        amountInLocalCurrencyLabel.textColor = Pallette.color3
        sendButton.setTitleColor(Pallette.color2, for: .normal)
        sendButton.backgroundColor = Pallette.color4
    }
    
    func setupPickerView() {
        countryCodeTextField.inputView = pickerView
        pickerView.selectedRow = .just(.nigeria) // default value inside pickerView

        pickerView.selectedRow?
            .compactMap{$0}
            .subscribe { country in
                self.countryCodeTextField.text = self.countries[country]?.flagWithCode
            }
            .disposed(by: disposeBag)
    }

    func bindViewModel() {
        let input = SendTransactionsViewModel
            .Input(firstName: firstNameTextField.rx.text.orEmpty.asDriver(),
                lastName: lastNameTextField.rx.text.orEmpty.asDriver(),
                phoneNumber: phoneTextField.rx.text.orEmpty.asDriver(),
                amountToSendInBinaria: amountInBinariaToSendTextField.rx.text.orEmpty.asDriver(),
                   sendAction: sendButton.rx.tap.asDriver())
        let output = viewModel.transform(input: input)
        
        _ = output.amountInLocalCurrency
            .drive(amountInLocalCurrencyLabel.rx.text)
        
        output.isValid
            .drive(onNext: { [weak self] isValid in
                self?.sendButton.isEnabled = isValid
                self?.sendButton.backgroundColor = Pallette.color4.withAlphaComponent(isValid ? 1 : 0.5)
            }).disposed(by: disposeBag)
    }
    
}
