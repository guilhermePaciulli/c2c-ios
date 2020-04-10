//
//  UIViewController+Camera.swift
//  C2C
//
//  Created by Guilherme Paciulli on 09/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit
import PromiseKit

protocol MediaCapturePresentable {
    func didSelectImage(_ image: UIImage)
}

private var delegate: MediaCapturePresentable?

extension UIViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func startSelectingImage(_ del: MediaCapturePresentable) {
        delegate = del
        let alert: UIAlertController = .init(title: "What do you preffer?", message: nil, preferredStyle: .actionSheet)
        let cameraAction: UIAlertAction = .init(title: "Camera", style: .default) { (_) in
            self.open(.camera)
            alert.dismiss(animated: true)
        }
        let galeryAction: UIAlertAction = .init(title: "Select from your photos", style: .default) { (_) in
            self.open(.photoLibrary)
            alert.dismiss(animated: true)
        }
        let cancelAction: UIAlertAction = .init(title: "Cancel", style: .default) { (_) in
            alert.dismiss(animated: true)
        }
        alert.addAction(cameraAction)
        alert.addAction(galeryAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func open(_ type: UIImagePickerController.SourceType) {
        let cameraController = UIImagePickerController()
        cameraController.delegate = self
        cameraController.sourceType = type
        present(cameraController, animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            delegate?.didSelectImage(image)
        }
        picker.dismiss(animated: true)
    }
    
}
