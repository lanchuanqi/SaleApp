//
//  AddClientController+handleSave.swift
//  SaleApp
//
//  Created by logan on 2018/4/11.
//  Copyright © 2018 Chuanqi. All rights reserved.
//

import UIKit

extension AddClientController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @objc func handleClientPhotoSelect(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            clientImageView.image = image
            selectedImage = image
        }else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            clientImageView.image = originalImage
            selectedImage = originalImage
        }
        dismiss(animated: true, completion: nil)
    }
}
