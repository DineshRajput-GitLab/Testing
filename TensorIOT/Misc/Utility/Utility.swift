//
//  Utility.swift
//  TensorIOT
//
//  Created by Dinesh Rajput on 23/09/23.
//

import Foundation
import UIKit

// MARK: Global Parameters
let appDelegate = UIApplication.shared.delegate as! AppDelegate
public typealias Parameters = [String: Any]


class Utility: NSObject {
    
    class func showNetWorkAlert() {
        showAlertWithMessage("Check Network connection", title:"Network Alert")
    }
    
    class func showAlertWithMessage(_ message: String, title: String, handler:(() -> ())? = nil) {
        DispatchQueue.main.async {
            //** If any Alert view is alrady presented then do not show another alert
            var viewController : UIViewController!
            if let vc  = UIApplication.currentViewController() {
                if (vc.isKind(of: UIAlertController.self)) {
                    return
                } else {
                    viewController = vc
                }
            } else {
                viewController = appDelegate.window?.rootViewController!
            }
            
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (_) in
                handler?()
            }))
           viewController!.present(alert, animated: true, completion: nil)
            //viewController.present(alert, animated: true)

        }
        
    }
    
}



