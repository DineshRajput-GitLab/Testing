//
//  UIImageView.swift
//  TensorIOT
//
//  Created by Dinesh Rajput on 27/09/23.
//

import Foundation
import UIKit

extension UIImageView {
    
    func saveImage(){
    guard let image = self.image, let data = image.jpegData (compressionQuality: 0.5) else { return }
      let encoded = try! PropertyListEncoder ().encode (data)
      UserDefaults.standard.set(encoded, forKey: "image")
    }
    
    func loadImage() {
        guard let data = UserDefaults.standard.data(forKey: "image") else { return }
        let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
        let image = UIImage(data: decoded)
        self.image = image
    }
}
