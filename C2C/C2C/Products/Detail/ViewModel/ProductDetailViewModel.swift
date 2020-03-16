//
//  ProductDetailViewModel.swift
//  C2C
//
//  Created by Guilherme Horcaio Paciulli on 16/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import Kingfisher
import UIKit

protocol ProductDetailViewModelProtocol {
    func fetchObject()
    func didTapBuyButton()
    func didTapExitButton()
}

class ProductDetailViewModel: ProductDetailViewModelProtocol {
    
    // MARK:- Properties
    var view: ProductDetailViewControllerPresentable?
    var product: ProductAttributes?
    var coordinator: BasicCoordinationProtocol?
    
    // MARK:- Viewmodel delegate
    func fetchObject() {
        guard let product = product else { NSLog("Error: product not set at ProductDetailViewModel"); return; }
        view?.setProduct(name: product.name)
        view?.setProduct(description: product.attributesDescription)
        let productPrice = "R$"+String(product.price)
        view?.setProduct(price: productPrice)
        guard let url = URL(string: product.productImageURL) else { return }
        view?.setProductImage()?.kf.setImage(with: url)
    }
    
    func didTapBuyButton() {
        coordinator?.presentNextStep()
    }
    
    func didTapExitButton() {
        coordinator?.presentPreviousStep()
    }
    
}
