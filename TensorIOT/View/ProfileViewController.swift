//
//  ProfileViewController.swift
//  TensorIOT
//
//  Created by Dinesh Rajput on 23/09/23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK:- IBOultes Properties
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userDetailLabel: UILabel!
    
    
    // MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let uesrName = UserDefaults.standard.string(forKey: "userName")
        let uesrDetail = UserDefaults.standard.string(forKey: "uesrBioDetail")
        userImageView.loadImage()
        userImageView.layer.cornerRadius = 50
        userNameLabel.text = uesrName?.capitalized ?? "Brendan Moore"
        userDetailLabel.text = uesrDetail?.capitalized ?? "C10 More Protacting"

    }
 
}

