//
//  ImagePicker.swift
//  FamilyFirst
//
//  Created by Benedikt Langer on 04.07.19.
//  Copyright © 2019 Niklas. All rights reserved.
//

import UIKit

extension AddMemberSubviewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func getImage() -> UIImage? {
        var newImage: UIImage?
        choosePhotoMode()
        if let newPhoto = newPhoto {
            newImage = newPhoto
            self.newPhoto = nil
        }
        return newImage
    }

    func choosePhotoMode() {
        let optionMenu = UIAlertController(title: nil, message: "Choose a Image", preferredStyle: .actionSheet)
        let choosePhoto = UIAlertAction(title: "Choose Photo", style: .default, handler: { (_: UIAlertAction!) -> Void in self.photoLibrary() })

        let takePhoto = UIAlertAction(title: "Take Photo", style: .default, handler: { (_: UIAlertAction!) -> Void in self.camera() })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        optionMenu.addAction(choosePhoto)
        optionMenu.addAction(takePhoto)
        optionMenu.addAction(cancelAction)

        present(optionMenu, animated: true, completion: nil)
    }

    func camera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            selectImageFrom(.photoLibrary)
            return
        }
        selectImageFrom(.camera)
    }

    func photoLibrary() {
        guard UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) else {
            return
        }
        selectImageFrom(.photoLibrary)
    }

    func selectImageFrom(_ source: ImageSource) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        switch source {
        case .photoLibrary:
            imagePicker.sourceType = .photoLibrary
        case .camera:
            imagePicker.sourceType = .camera
        }
        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newPhoto = image
        } else {
            print("Something went wrong")
        }
        dismiss(animated: true, completion: nil)
    }
}
