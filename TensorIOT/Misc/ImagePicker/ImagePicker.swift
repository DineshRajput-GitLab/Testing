//
//  ImagePicker.swift
//  TensorIOT
//
//  Created by Dinesh Rajput on 23/09/23.
//

import Foundation
import Photos
import UIKit

class ImagePicker: NSObject {
  
  enum MediaType {
    case image
    case video
  }
  
  // MARK: - UIImagePicker Action Methods
  static func openCameraOrLibrary(_ vController: UIViewController, mediaType: MediaType = MediaType.video, actionHandler: ((String) -> Void)? = nil) {
    let imagePicker = UIImagePickerController()
    
    let alert: UIAlertController = UIAlertController(title: "Select Camera or Photo Library", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
    let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) { _ in
      /// Check the camera permission
      ImagePicker.checkCameraPerrmision(vController, ImagePicker: imagePicker)
    }
    
    let gallaryAction = UIAlertAction(title: "Photo Library", style: UIAlertAction.Style.default) { _ in
      // Check the Gallery permission
      ImagePicker.checkPhotoLibraryPermission(vController, ImagePicker: imagePicker)
    }
    
    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { _ in
      if let actionHandler = actionHandler {
        actionHandler("cancel")
      }
    }
    
    // Add the actions
    imagePicker.delegate = vController as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
    if mediaType == .image {
      imagePicker.mediaTypes = ["public.image"]
    } else {
      imagePicker.mediaTypes = ["public.movie"]
      imagePicker.videoMaximumDuration = 29.0
    }
    alert.addAction(cameraAction)
    alert.addAction(gallaryAction)
    alert.addAction(cancelAction)
    
    if Thread.isMainThread {
      vController.present(alert, animated: true, completion: nil)
    } else {
      DispatchQueue.main.sync {
        vController.present(alert, animated: true, completion: nil)
      }
    }
  }
  
  static func openPhotoLibrary(
    _ vController: UIViewController,
    mediaType: MediaType = MediaType.video,
    videoMaximumDuration: TimeInterval) {
    ///
    let imagePicker = UIImagePickerController()
    imagePicker.videoExportPreset = AVAssetExportPresetPassthrough
        
    // Add the actions
    if mediaType == .image {
      imagePicker.mediaTypes = ["public.image"]
    } else {
      imagePicker.mediaTypes = ["public.movie"]
      imagePicker.videoMaximumDuration = videoMaximumDuration
    }
    
    imagePicker.delegate = vController as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
    
    // Check the Gallery permission
    ImagePicker.checkPhotoLibraryPermission(vController, ImagePicker: imagePicker)
  }
  
  static private func openCamera(_ vController: UIViewController, ImagePicker imagePicker: UIImagePickerController) {
   
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
      
      if Thread.isMainThread {
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
        imagePicker.allowsEditing = true
        imagePicker.videoMaximumDuration = 29.0
        imagePicker.modalPresentationStyle = .overCurrentContext
        //imagePicker.cameraOverlayView
        vController.present(imagePicker, animated: true)
        
      } else {
        DispatchQueue.main.sync {
          imagePicker.sourceType = UIImagePickerController.SourceType.camera
          imagePicker.allowsEditing = true
          imagePicker.videoMaximumDuration = 29.0
          imagePicker.modalPresentationStyle = .overCurrentContext
          vController.present(imagePicker, animated: true)
        }
      }
    } else {
      let alertController: UIAlertController = UIAlertController(
        title: "Warning",
        message: "Camera is not available on this Device or accesibility has been revoked!",
        preferredStyle: UIAlertController.Style.alert)
      let ok: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alertController.addAction(ok)
      
      if Thread.isMainThread {
        vController.present(alertController, animated: true, completion: nil)
      } else {
        DispatchQueue.main.sync {
          vController.present(alertController, animated: true, completion: nil)
        }
      }
    }
  }
  
  
  static private func openGallary(_ vController: UIViewController, ImagePicker imagePicker: UIImagePickerController) {
    if Thread.isMainThread {
      imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
      imagePicker.allowsEditing = true
      imagePicker.modalPresentationStyle = .overCurrentContext
      vController.present(imagePicker, animated: true, completion: nil)
    } else {
      DispatchQueue.main.sync {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.modalPresentationStyle = .overCurrentContext
        vController.present(imagePicker, animated: true, completion: nil)
      }
    }
  }
  
  // MARK: - Pemissions
    
  /// Check the camera permission
  static private func checkCameraPerrmision(_ vController: UIViewController, ImagePicker imagePicker: UIImagePickerController) {
    if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
      //already authorized
      ImagePicker.openCamera(vController, ImagePicker: imagePicker)
    } else {
      AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
        if granted {
          //access allowed
          ImagePicker.openCamera(vController, ImagePicker: imagePicker)
        } else {
          //access denied
          self.alertPromptToAllowPhotoLibraryAccessViaSetting(vController)
        }
      })
    }
  }
  
  /// Check the Gallery permission
  static private func checkPhotoLibraryPermission(_ vController: UIViewController, ImagePicker imagePicker: UIImagePickerController) {
    // Get the current authorization state.
    let status = PHPhotoLibrary.authorizationStatus()
    
    if status == PHAuthorizationStatus.authorized {
      // Access has been granted.
      ImagePicker.openGallary(vController, ImagePicker: imagePicker)
    } else if status == PHAuthorizationStatus.denied {
      // Access has been denied.
      self.alertPromptToAllowCameraAccessViaSetting(vController)
    } else if status == PHAuthorizationStatus.notDetermined {
      // Access has not been determined.
      PHPhotoLibrary.requestAuthorization({ (newStatus) in
        if newStatus == PHAuthorizationStatus.authorized {
          ImagePicker.openGallary(vController, ImagePicker: imagePicker)
        } else {
          // Access has been denied.
          self.alertPromptToAllowCameraAccessViaSetting(vController)
        }
      })
    } else if status == PHAuthorizationStatus.restricted {
      // Restricted access - normally won't happen.
      self.alertPromptToAllowCameraAccessViaSetting(vController)
    }
  }
  
  static private func alertPromptToAllowCameraAccessViaSetting(_ vController: UIViewController) {
    let alertController1 = UIAlertController(
      title: nil,
      message: "\("TensorIOT") does not have access to your photos or videos. To enable access, tap Settings and turn on Photos.",
      preferredStyle: .alert)
    
    let settingAction = UIKit.UIAlertAction(title: "Settings", style: .destructive) { _ in
      UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    }
    alertController1.addAction(settingAction)
    
    let cancelActions = UIKit.UIAlertAction(title: "Cancel", style: .cancel) { _ in
    }
    alertController1.addAction(cancelActions)
    if Thread.isMainThread {
      vController.present(alertController1, animated: true, completion: nil)
    } else {
      DispatchQueue.main.sync {
        vController.present(alertController1, animated: true, completion: nil)
      }
    }
  }
  
  static private func alertPromptToAllowPhotoLibraryAccessViaSetting(_ vController: UIViewController) {
    let alertController1 = UIAlertController(
      title: nil,
      message: "\("TensorIOT") does not have access to your photos or videos. To enable access, tap Settings and turn on Photos.",
      preferredStyle: .alert)
    
    let settingAction = UIKit.UIAlertAction(title: "Settings", style: .destructive) { (_) in
      UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    }
    alertController1.addAction(settingAction)
    
    let cancelActions = UIKit.UIAlertAction(title: "Cancel", style: .cancel) { (_) in
    }
    alertController1.addAction(cancelActions)
    if Thread.isMainThread {
      vController.present(alertController1, animated: true, completion: nil)
    } else {
      DispatchQueue.main.sync {
        vController.present(alertController1, animated: true, completion: nil)
      }
    }
  }
}
