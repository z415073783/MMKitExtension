//
//  SystemCameraManager.swift
//  Odin-UC
//
//  Created by zlm on 2016/12/14.
//  Copyright © 2016年 yealing. All rights reserved.
//

import UIKit
import AVFoundation
public class SystemCameraManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public static let getInstance = SystemCameraManager()
    public typealias CallFuncBlock = (_ image: UIImage?, _ pick: UIImagePickerController) -> Void
    var _callBlock: CallFuncBlock?
    //打开相册 PopoverController需要打开的目标视图(pad需要传入targetView属性)
    public func openPhotoAlbum(allowsEditing: Bool = true, targetView: UIView? = nil, MMCallBlock:@escaping CallFuncBlock) {
        _callBlock = MMCallBlock
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {

            let imagePickerC = UIImagePickerController()
            imagePickerC.delegate = self
            imagePickerC.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePickerC.allowsEditing = allowsEditing
            if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad && allowsEditing == true {
                guard let sourceView = targetView else { return }
                let popover = UIPopoverController(contentViewController: imagePickerC)
                popover.present(from: CGRect(x: -150+sourceView.frame.size.width/2,
                                             y: 0,
                                             width: 300,
                                             height: 300),
                                in: sourceView,
                                permittedArrowDirections: UIPopoverArrowDirection.any,
                                animated: true)
            } else {
                kRootViewController?.present(imagePickerC, animated: true, completion: {
                })
            }
           
//            UIApplication.shared.setStatusBarStMMe(UIStatusBarStMMe.default, animated: true)
        }
    }
    //打开相机
    public func openCamera(allowsEditing: Bool = true, targetView: UIView? = nil, MMCallBlock:@escaping CallFuncBlock) {
        _callBlock = MMCallBlock
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        if authStatus == AVAuthorizationStatus.restricted || authStatus == AVAuthorizationStatus.denied {
           
            MMAlertNoButtonView.show(MMLanguage.localized("应用相机权限受限,请在设置中启用"))
            return
        }

        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePickerC = UIImagePickerController()
            imagePickerC.sourceType = UIImagePickerController.SourceType.camera
            imagePickerC.showsCameraControls = true
            imagePickerC.cameraCaptureMode = UIImagePickerController.CameraCaptureMode.photo
            imagePickerC.delegate = self
            imagePickerC.allowsEditing = allowsEditing

            if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad && allowsEditing == true {
                guard let sourceView = targetView else { return }
                let popover = UIPopoverController(contentViewController: imagePickerC)
                popover.present(from: CGRect(x: -150+sourceView.frame.size.width/2,
                                             y: 0,
                                             width: 300,
                                             height: 300),
                                in: sourceView,
                                permittedArrowDirections: UIPopoverArrowDirection.any,
                                animated: true)
            } else {
                kRootViewController?.present(imagePickerC, animated: true, completion: {
                })
            }

        }
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        _callBlock?(nil, picker)
        
//        UIApplication.shared.setStatusBarStMMe(UIStatusBarStMMe.lightContent, animated: true)

        picker.dismiss(animated: true) {

        }
    }
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var image: UIImage?
        
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = img
        }
        else if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = img
        }
    
        _callBlock?(image?.compressSize(), picker)
//        picker.dismiss(animated: true) {
//
//        }
    }

}
