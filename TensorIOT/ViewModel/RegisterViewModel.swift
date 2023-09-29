//
//  RegisterViewModel.swift
//  TensorIOT
//
//  Created by Dinesh Rajput on 23/09/23.
//

import Foundation
import UIKit

class RegisterViewModel {
    var userName: String?
    var uesrBioDetail: String?
    var uesrImage: UIImage?
    
    //MARK: - Validate Method
    func isTextFieldsValidation(email: String, userName: String, password: String, confirmPassword: String) -> Bool {
        guard !(email.isEmpty) else {
            Utility.showAlertWithMessage("Please enter email", title: "Alert")
            return false
        }
        guard email.isValid(type: .email) else {
            Utility.showAlertWithMessage("Incorrect email.", title: "Alert")
            return false
        }
        
        guard !(userName.isEmpty) else {
            Utility.showAlertWithMessage("Enter a username.", title: "Alert")
            return false
        }
        guard userName.isValid(type: .userName) else {
            Utility.showAlertWithMessage("Please a username.", title: "Alert")
            return false
        }
        
        guard !(password.isEmpty) else {
            Utility.showAlertWithMessage("Please enter a password.", title: "Alert")
            return false
        }
        guard password.isValid(type: .password) else {
            Utility.showAlertWithMessage("Password needs to be at least six characters long, and contain one uppercase letter and one number.", title: "Alert")
            return false
        }
        guard !(confirmPassword.isEmpty) else {
            Utility.showAlertWithMessage("Please enter confirm password.", title: "Alert")
            return false
        }
        guard password == confirmPassword else {
            Utility.showAlertWithMessage("Password and confirm password do not match.", title: "Alert")
            return false
        }
        return true
    }
    
}
