//
//  CreateProductViewModel.swift
//  C2C
//
//  Created by Guilherme Paciulli on 08/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

protocol CreateProductViewModelProtocol {
    func didTapCreateProduct()
    func didTapBackButton()
}

class CreateProductViewModel: CreateProductViewModelProtocol {
    
    // MARK:- Properties
    weak var interactor: ProductsInteractorProtocol?
    weak var view: CreateProductPresentable?
    weak var coordinator: ProductsCoordinationProtocol?
    var selectedProduct: ProductAttributes?
    
    // MARK:- Delegate methods
    func didTapCreateProduct() {
        guard let view = self.view else { return }
        var errors = ProductFields.allCases.compactMap({ return $0.validate(string: view.getField($0)) })
        if view.getProductImage() == nil { errors.append("You have to add a product picture") }
        if errors.isEmpty, let prod = createProduct() {
            view.startLoading()
            interactor?.createProduct(product: prod).done({ [weak self] (_) in
                view.stopLoading()
                view.showAlert(withTitle: "Product created successfully", message: "").done { (_) in
                    self?.coordinator?.presentNextStep()
                }
            }).catch({ (error) in
                view.stopLoading()
                _ = view.showAlert(withTitle: error.localizedTitle, message: error.localizedDescription)
            })
        } else {
            _ = view.showAlert(withTitle: "Invalid fields", message: errors.joined(separator: ", "))
        }
    }
    
    func createProduct() -> CreateProduct? {
        guard let view = self.view else { return nil }
        return .init(name: view.getField(.Name), description: view.getField(.Description), price: view.getField(.Price), picture: view.getProductImage() ?? .init())
    }
    
    func didTapBackButton() {
        coordinator?.presentPreviousStep()
    }
    
}
