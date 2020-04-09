//
//  CreateProduct+Presentable.swift
//  C2C
//
//  Created by Guilherme Paciulli on 08/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

protocol CreateProductPresentable: class {
    func startLoading()
    func stopLoading()
    func showAlert(withTitle title: String, message: String)
    func getProductImage() -> UIImage?
    func getField(_ field: ProductFields) -> String
}

extension CreateProductTableViewController: CreateProductPresentable {
    
    func startLoading() {
        showSpinnerView()
    }
    
    func stopLoading() {
        removeSpinnerView()
    }
    
    func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            alert.dismiss(animated: true)
        }
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
    func getProductImage() -> UIImage? {
        return productImage?.image
    }
    
    func getField(_ field: ProductFields) -> String {
        switch field {
        case .Name:
            return productName?.text ?? ""
        case .Description:
            return productDescription?.text ?? ""
        case .Price:
            return productPrice?.text ?? ""
            
        }
    }
}
