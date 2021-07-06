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
        amountInLocalCurrencyLabel.text = "amount transferred is ... "
        amountInLocalCurrencyLabel.font = UIFont.systemFont(ofSize: 14)
        amountInLocalCurrencyLabel.numberOfLines = 2
        sendButton.setTitleColor(Pallette.color2, for: .normal)
        sendButton.backgroundColor = Pallette.color4
    }
    
    func setupPickerView() {
        countryCodeTextField.inputView = pickerView
        pickerView.selectedRow = .just(defaultCountry)
        
        // populate country picker whenever pick a new country
        pickerView.selectedRow
            .subscribe { country in
                self.countryCodeTextField.text = self.countries[country]?.flagWithCode
            }
            .disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        let selectedCountryDriver = pickerView.selectedRow.asDriver(onErrorJustReturn: defaultCountry)
        let phoneNumberDidEndEditingDriver = phoneTextField.rx.controlEvent([.editingDidEnd])
            .map{self.phoneTextField.text ?? "" }
            .asDriver(onErrorJustReturn: "")
        let binariaDidEndEditing = amountInBinariaToSendTextField.rx.controlEvent([.editingDidEnd])
            .map{self.amountInBinariaToSendTextField.text ?? "" }
            .asDriver(onErrorJustReturn: "")
        
        let input = SendTransactionsViewModel
            .Input(firstName: firstNameTextField.rx.text.orEmpty.asDriver(),
                   lastName: lastNameTextField.rx.text.orEmpty.asDriver(),
                   phoneNumber: phoneTextField.rx.text.orEmpty.asDriver(),
                   phoneNumberEndEditing: phoneNumberDidEndEditingDriver,
                   amountToSendInBinaria: amountInBinariaToSendTextField.rx.text.orEmpty.asDriver(),
                   binariaDidEndEditing: binariaDidEndEditing,
                   sendAction: sendButton.rx.tap.asDriver(),
                   selectedCountry: selectedCountryDriver)
        
        let output = viewModel.transform(input: input)
        
        _ = output.amountInLocalCurrency
            .drive(amountInLocalCurrencyLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.isValid
            .drive(onNext: { [weak self] isValid in
                self?.sendButton.isEnabled = isValid
                self?.sendButton.backgroundColor = Pallette.color4.withAlphaComponent(isValid ? 1 : 0.5)
            }).disposed(by: disposeBag)
        
        // validate binary
        output.isValidBinaria
            .drive(onNext: { [weak self] isValid in
                self?.amountInBinariaToSendTextField.errorMessage =  isValid ? nil : "please enter valid binary"
            }).disposed(by: disposeBag)
        
        // validate phone number with country code selected
        Driver.combineLatest(selectedCountryDriver, output.isValidPhoneNumber)
            .drive(onNext: { [weak self] country, isValid in
                self?.phoneTextField.errorMessage =  isValid ? nil : "please enter valid phone"
                self?.countryCodeTextField.text = self?.countries[country]?.flagWithCode
            }).disposed(by: disposeBag)
        
        output.alertTrigger
            .drive(onNext: {  _ in
                // show local notification here when press send, send button is only enabled if the form is valid
            }).disposed(by: disposeBag)
    }
    
}
