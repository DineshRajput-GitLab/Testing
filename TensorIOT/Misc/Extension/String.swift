//
//  String.swift
//  TensorIOT
//
//  Created by Dinesh Rajput on 23/09/23.
//

import Foundation

// MARK:- String Extension
extension String {
    func isValid(type: RegexType) -> Bool {
        let regex = type.getRegex()
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
}

