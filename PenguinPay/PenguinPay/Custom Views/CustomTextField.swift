//
//  CustomTextField.swift
//  PenguinPay
//
//  Created by Bassant Ashraf on 03/07/2021.
//

import SkyFloatingLabelTextField

class CustomTextField: SkyFloatingLabelTextField {
    
    let mainColor1 = Pallette.color3
    let mainColor2 = Pallette.color2
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        tintColor = mainColor1
        textColor = mainColor2
        lineColor = mainColor1
        lineErrorColor = .red
        selectedLineColor = mainColor1
        selectedTitleColor = mainColor2
        selectedLineColor = mainColor2
        placeholderColor = mainColor1
        titleColor = mainColor2
    }
    
}
