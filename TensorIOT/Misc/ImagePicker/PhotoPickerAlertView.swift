//
//  ImagePicker.swift
//  TensorIOT
//
//  Created by Dinesh Rajput on 23/09/23.
//

import Foundation
import UIKit

// MARK: Custom AlertView
class PhotoPickerAlertView: NSObject {
    
    // MARK: AlertPicker Type
    enum ActionSourceType {
        case photoLibrary
        case camera
    }
    
    static var callBackSourceType:((ActionSourceType) -> (Void))?
    
    // MARK: Show Picker Methods
    static func show(fromController viewController: UIViewController, isProfile: Bool, handler:@escaping (ActionSourceType)->(Void)) {
        callBackSourceType = handler
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            PhotoPickerAlertView.callBackSourceType?(.camera)
        }))
        
        alertController.addAction(UIAlertAction(title: "Photos", style: .default, handler: { (action) in
            PhotoPickerAlertView.callBackSourceType?(.photoLibrary)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}


