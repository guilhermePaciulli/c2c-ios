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
        if view.getProductImage() == nil { errors.append("You have to add a profile picture") }
        if errors.isEmpty /*let acc = getAccount()*/ {
        } else {
            view.showAlert(withTitle: "Invalid fields", message: errors.joined(separator: ", "))
        }
    }
    
}
