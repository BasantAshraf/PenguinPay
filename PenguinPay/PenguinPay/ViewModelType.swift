//
//  ViewModelType.swift
//  PenguinPay
//
//  Created by Bassant Ashraf on 02/07/2021.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
