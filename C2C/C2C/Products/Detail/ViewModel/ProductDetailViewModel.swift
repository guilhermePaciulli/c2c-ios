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
    var purchaseInterator: PurchaseInteractorProtocol?
    var userInteractor: UserInteractorProtocol?
    var product: ProductAttributes?
    
    // MARK:- Viewmodel delegate
    func fetchObject() {
        guard let id = productID else { NSLog("Error: product not set at ProductDetailViewModel"); return; }
        
        view?.startLoading()
        interactor?.getProduct(withId: id).done(on: .main, { [weak self] (data) in
            let product = data.attributes
            self?.product = product
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
        guard let product = self.product else { return }
        view?.showDecisionAlert(withTitle: "Are you sure you want to buy \(product.name)?", message: "")
            .done(on: .main, { _ in
                self.buy(product: product)
            }).cauterize()
    }
    
    func didTapExitButton() {
        coordinator?.presentPreviousStep()
    }
    
    // MARK:- Private methods
    private func buy(product: ProductAttributes) {
        view?.startLoading()
        purchaseInterator?.purchase(product: product).done(on: .main, { [weak self] (_) in
            self?.view?.stopLoading()
            self?.endPurchase()
        }).catch({ [weak self] (error) in
            self?.view?.stopLoading()
            self?.view?.showAlert(withTitle: error.localizedTitle, message: error.localizedDescription)
        })
    }
    
    private func endPurchase() {
        let title = "Product purchased successfully"
        let msg = "See your purchase in Purchases sections in your profile"
        view?.showAlert(withTitle: title, message: msg).done(on: .main, { [weak self] (_) in
            self?.coordinator?.presentNextStep()
        })
    }
    
}
