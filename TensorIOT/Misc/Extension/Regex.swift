//
//  String.swift
//  TensorIOT
//
//  Created by Dinesh Rajput on 23/09/23.
//

import Foundation

enum RegexType {
    case email
    case password
    case userName
    
    func getRegex() -> String {
        switch self {
        case .email:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"//"[A-Z0-9a-z_%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,64}"  //standard email validation
            
        case .password:
            return "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,50}$"//"[a-zA-z0-9!\"#$%&'()*+,-./:;<=>?@\\[\\]^_`{|}~]{6,12}" //any character with infinite length
            
        case .userName:
            return "[A-Z0-9a-z._%+-](?=.*[a-z]).{1,20}"
       
        }
    }
}

