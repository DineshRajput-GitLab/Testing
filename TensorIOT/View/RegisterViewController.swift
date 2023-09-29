//
//  RegisterViewController.swift
//  TensorIOT
//
//  Created by Dinesh Rajput on 23/09/23.
//

import UIKit

class RegisterViewController: UIViewController {
    
// MARK:- IBOutlets Properties
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var confirmPWDTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var shortBioTextField: UITextField!
    
    // MARK:- Instance Properties
    let registerViewModel = RegisterViewModel()
    
    // MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userImageView.layer.cornerRadius = 50
    }
    private func saveUserInfDetails() {
        UserDefaults.standard.set(userNameTextField.text ?? "", forKey: "userName")
        UserDefaults.standard.set(shortBioTextField.text ?? "", forKey: "uesrBioDetail")
        userImageView.saveImage()
    }
    

    // MARK: - Open ActionSheet Methods
    private func openActionSheet() {
      let message = "Chose Midiya Soucrce"
      let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
      alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
        self.presentImagePickerController(sourceType: .camera)
      }))
      let title = "Gellary"
      alert.addAction(UIAlertAction(title: title, style: .default, handler: { (_) in
        self.presentImagePickerController(sourceType: .photoLibrary)
      }))
      
      alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
      self.present(alert, animated: true)
    }
    
    // MARK: - Prsent ImagePicker
    private func presentImagePickerController(sourceType: UIImagePickerController.SourceType) {
      let imagePickerController = UIImagePickerController()
      imagePickerController.sourceType = sourceType
      imagePickerController.delegate = self
      imagePickerController.allowsEditing = false
      imagePickerController.modalPresentationStyle = .overCurrentContext
      present(imagePickerController, animated: true)
    }
    
    // MARK:- IBaction Methods
    @IBAction func signUpButtonAction(_ sender: UIButton) {
        guard(self.registerViewModel.isTextFieldsValidation(email: emailTextField.text ?? "", userName: userNameTextField.text ?? "", password: pwdTextField.text ?? "", confirmPassword: confirmPWDTextField.text ?? "")) else {
            return
        }
        saveUserInfDetails()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let userProfileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        
        navigationController?.pushViewController(userProfileVC, animated: true)
        

    }
    @IBAction func setDisplayImageButtonAction(_ sender: UIButton) {
        openActionSheet()

    }
    
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate Methods

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

 func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
   if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
       userImageView.image = pickedImage
     picker.dismiss(animated: true, completion: nil)
   }
 }

 func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
   picker.dismiss(animated: true, completion: nil)
 }
}


