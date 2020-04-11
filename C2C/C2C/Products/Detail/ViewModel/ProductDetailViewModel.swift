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
    var productID: Int?
    var coordinator: BasicCoordinationProtocol?
    var interactor: ProductsInteractor?
    var userInteractor: UserInteractorProtocol?
    var blurView: UIView?
    
    // MARK:- Viewmodel delegate
    func fetchObject() {
        guard let id = productID else { NSLog("Error: product not set at ProductDetailViewModel"); return; }
        
        view?.startLoading()
        interactor?.getProduct(withId: id).done(on: .main, { [weak self] (data) in
            let product = data.attributes
            self?.view?.setProduct(name: product.name)
            self?.view?.setProduct(description: product.attributesDescription)
            let productPrice = "R$"+String(product.price)
            self?.view?.setProduct(price: productPrice)
            guard let url = URL(string: product.productImageURL) else { return }
            self?.view?.setProductImage()?.kf.indicatorType = .activity
            self?.view?.setProductImage()?.kf.setImage(with: url)
            self?.view?.stopLoading()
        }).catch({ [weak self] (error) in
            self?.view?.stopLoading()
            self?.view?.showAlert(withTitle: error.localizedTitle, message: error.localizedDescription)
        })
        
    }
    
    func didTapBuyButton() {
        coordinator?.presentNextStep()
    }
    
    func didTapExitButton() {
        coordinator?.presentPreviousStep()
    }
    
}
