//
//  SendTransactionsViewController.swift
//  PenguinPay
//
//  Created by Bassant Ashraf on 02/07/2021.
//

import UIKit
import RxSwift
import RxCocoa

class SendTransactionsViewController: UIViewController {
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstNameTextField: CustomTextField!
    @IBOutlet weak var lastNameTextField: CustomTextField!
    @IBOutlet weak var phoneTextField: CustomTextField!
    @IBOutlet weak var amountInBinariaToSendTextField: CustomTextField!
    @IBOutlet weak var amountInLocalCurrencyLabel: UILabel!
    
    let viewModel = SendTransactionsViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    
    func setupView() {
        firstNameTextField.placeholder = "First Name"
        lastNameTextField.placeholder = "Last Name"
        phoneTextField.placeholder = "Phone"
        amountInBinariaToSendTextField.placeholder = "amount In Binaria"
        sendButton.layer.cornerRadius = 15
        view.backgroundColor = Pallette.color1
        titleLabel.textColor = Pallette.color2
        amountInLocalCurrencyLabel.textColor = Pallette.color3
        sendButton.setTitleColor(Pallette.color2, for: .normal)
        sendButton.backgroundColor = Pallette.color4
    }

    func bindViewModel() {
        let input = SendTransactionsViewModel
            .Input(firstName: firstNameTextField.rx.text.orEmpty.asDriver(),
                lastName: lastNameTextField.rx.text.orEmpty.asDriver(),
                phoneNumber: phoneTextField.rx.text.orEmpty.asDriver(),
                amountToSendInBinaria: amountInBinariaToSendTextField.rx.text.orEmpty.asDriver(),
                   sendAction: sendButton.rx.tap.asDriver())
        let output = viewModel.transform(input: input)
        
        _ = output.amountInLocalCurrency.drive(amountInLocalCurrencyLabel.rx.text)
        
//        output.isValid.asObservable()
//                  .bind(to: sendButton.rx.isEnabled)
//                  .disposed(by: disposeBag)
//
        output.isValid
            .drive(onNext: { [weak self] isValid in
                self?.sendButton.isEnabled = isValid
                self?.sendButton.backgroundColor = Pallette.color4.withAlphaComponent(isValid ? 1 : 0.5)
            }).disposed(by: disposeBag)
    }
    
}

