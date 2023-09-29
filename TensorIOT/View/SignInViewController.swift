//
//  SignInViewController.swift
//  TensorIOT
//
//  Created by Dinesh Rajput on 23/09/23.
//

import UIKit

class SignInViewController: UIViewController {
    
// MARK:- IBOutlets Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK:- Instance Properties
    let signInVM = SignInViewModel()
    
    // MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   

// MARK:- IBAction Methods
    @IBAction func loginButtonAction(_ sender: UIButton) {
        guard(signInVM.isTextFieldsValid(email: emailTextField.text!, password: passwordTextField.text!)) else{
            return
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let userProfileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        navigationController?.pushViewController(userProfileVC, animated: true)
    }
    
    @IBAction func signupButtonAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signInVC = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
    
    
}
