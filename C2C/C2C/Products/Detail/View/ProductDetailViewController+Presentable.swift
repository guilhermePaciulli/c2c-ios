//
//  ProductDetailViewController+Presentable.swift
//  C2C
//
//  Created by Guilherme Horcaio Paciulli on 16/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit
import PromiseKit

protocol ProductDetailViewControllerPresentable {
    func startLoading()
    func stopLoading()
    func showDecisionAlert(withTitle title: String, message: String) -> Promise<Void>
    @discardableResult func showAlert(withTitle title: String, message: String) -> Guarantee<Void>
    func setProduct(name: String)
    func setProduct(price: String)
    func setProduct(description: String)
    func setProductImage() -> UIImageView?
}

extension ProductDetailViewController: ProductDetailViewControllerPresentable {
    
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
