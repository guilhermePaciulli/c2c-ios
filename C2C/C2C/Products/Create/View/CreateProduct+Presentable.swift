//
//  CreateProduct+Presentable.swift
//  C2C
//
//  Created by Guilherme Paciulli on 08/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

protocol CreateProductPresentable {
    func startLoading()
    func stopLoading()
    func showAlert(withTitle title: String, message: String)
    func getProductName() -> String
    func getProductDescription() -> String
    func getProductPrice() -> String
    func getProductImage() -> UIImage?
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
        let alertAction = UIAlertAction(title: "Ok", style: .default) { [weak self] (_) in
            alert.dismiss(animated: true)
//            self?.viewModel?.didTapExitButton()
        }
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
    func getProductName() -> String {
        return productName?.text ?? ""
    }
    
    func getProductDescription() -> String {
        return productDescription?.text ?? ""
    }
    
    func getProductPrice() -> String {
        return productPrice?.text ?? ""
    }
    
    func getProductImage() -> UIImage? {
        return productImage?.image
    }
}
