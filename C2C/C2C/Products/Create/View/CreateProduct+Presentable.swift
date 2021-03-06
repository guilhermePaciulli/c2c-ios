//
//  CreateProduct+Presentable.swift
//  C2C
//
//  Created by Guilherme Paciulli on 08/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit
import PromiseKit

protocol CreateProductPresentable: class {
    func startLoading()
    func stopLoading()
    func showAlert(withTitle title: String, message: String) -> Guarantee<Void>
    func getProductImage() -> UIImage?
    func getField(_ field: ProductFields) -> String
}

extension CreateProductViewController: CreateProductPresentable {
    
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
