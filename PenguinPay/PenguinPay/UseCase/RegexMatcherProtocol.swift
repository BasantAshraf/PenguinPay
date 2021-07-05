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
        guard let regex = try? NSRegularExpression(pattern: regex) else { return false }
        let range = NSRange(location: 0, length: text.utf16.count)
        return regex.firstMatch(in: text, options: [], range: range) != nil
    }
}
