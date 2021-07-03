//
//  RegexMatcherProtocol.swift
//  PenguinPay
//
//  Created by Bassant Ashraf on 03/07/2021.
//

import Foundation

protocol RegexMatcherProtocol {
    func matches(for regex: String, in text: String) -> Bool
}

extension RegexMatcherProtocol  {
    func matches(for regex: String, in text: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = text as NSString
            let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
            return !results.isEmpty
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return false
        }
    }
}
