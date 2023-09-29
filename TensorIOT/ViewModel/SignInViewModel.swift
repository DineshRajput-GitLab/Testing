//
//  SignInViewModel.swift
//  TensorIOT
//
//  Created by Dinesh Rajput on 23/09/23.
//

import Foundation

class SignInViewModel {
    
    // MARK: - Validation Methods TextField
    func isTextFieldsValid(email: String, password: String) -> Bool {
        guard !(email.isEmpty) else {
            Utility.showAlertWithMessage("Please enter email.", title: "Alert")
            return false
        }
        guard email.isValid(type: .email) else {
            Utility.showAlertWithMessage("Please enter valid email.", title: "Alert")
            return false
        }
        guard !(password.isEmpty) else {
            Utility.showAlertWithMessage("Please enter password.", title: "Alert")
            return false
        }
        guard password.isValid(type: .password) else {
            Utility.showAlertWithMessage("Please enter valid password.", title: "Alert")
            return false
        }
        return true
    }
   
}
