//
//  ProductDetailViewController+Presentable.swift
//  C2C
//
//  Created by Guilherme Horcaio Paciulli on 16/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

protocol ProductDetailViewControllerPresentable {
    func startLoading()
    func stopLoading()
    func showAlert(withTitle title: String, message: String)
    func setProduct(name: String)
    func setProduct(price: String)
    func setProduct(description: String)
    func setProductImage() -> UIImageView?
}

extension ProductDetailViewController: ProductDetailViewControllerPresentable {
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
            self?.viewModel?.didTapExitButton()
        }
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
    func setProduct(name: String) {
        productName?.text = name
    }
    
    func setProduct(price: String) {
        productPrice?.text = price
    }
    
    func setProduct(description: String) {
        productDescription?.text = description
    }
    
    func setProductImage() -> UIImageView? {
        return productImage
    }
    
}
