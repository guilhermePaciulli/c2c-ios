//
//  PurchaseDetailViewModel.swift
//  C2C
//
//  Created by Guilherme Paciulli on 11/05/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit
import Kingfisher

protocol PurchaseDetailViewModelProtocol: class {
    func viewWillAppear()
    func didTapToChangePurchaseStatus()
    func didTapBackButton()
    func getViewName() -> String
}

class PurchaseDetailViewModel: PurchaseDetailViewModelProtocol {
    
    // MARK:- Properties
    var view: PurchaseDetailPresentable?
    var purchase: Purchase?
    var coordinator: BasicCoordinationProtocol?
    var interactor: PurchaseInteractorProtocol?
    
    // MARK:- Protocol methods
    func getViewName() -> String {
        return isSellerPurchase() ? "You sold" : "You bought"
    }
    
    func viewWillAppear() {
        guard let purchase = purchase,
            let imgURL = URL(string: purchase.attributes.product.data.attributes.productImageURL) else { coordinator?.presentPreviousStep(); return; }
        
        view?.setZipCode(purchase.attributes.address.zipCode)
        view?.setProductName(purchase.attributes.product.data.attributes.name)
        view?.setProductDescription(purchase.attributes.product.data.attributes.attributesDescription)
        view?.setProductImage()?.kf.setImage(with: imgURL)
        let status = purchase.attributes.purchaseStatus.getTextAndColor()
        view?.setPurchaseStatus(withTitle: status.0, andColor: status.1)
        
        view?.setPaymentMethodHidden(isSellerPurchase())
        view?.setStatusButtonHidden(!shouldShowStatusButton())
        view?.setPaymentMethodEnding(getPaymentMethodEnding())
        view?.setStatusButtonText(purchase.attributes.purchaseStatus.getNextStatus())
    }
    
    func didTapToChangePurchaseStatus() {
        let title = "Are you sure you want to change this purchase status?"
        view?.showDecisionAlert(withTitle: title, message: "").done({ [weak self] (_) in
            self?.changePurchaseStatus()
        }).catch({ [weak self] (_) in
            self?.view?.stopLoading()
            self?.coordinator?.presentPreviousStep()
        })
    }
    
    func didTapBackButton() {
        coordinator?.presentPreviousStep()
    }
    
    // MARK:- Private methods
    private func isSellerPurchase() -> Bool {
        return purchase?.attributes.creditCard == nil
    }
    
    private func shouldShowStatusButton() -> Bool {
        guard let purchase = purchase else { return false }
        return purchase.attributes.purchaseStatus == .inTransit ||
            (isSellerPurchase() && purchase.attributes.purchaseStatus != .inTransit)
    }
    
    private func getPaymentMethodEnding() -> String {
        guard let creditCard = purchase?.attributes.creditCard?.number else { return "" }
        return String(creditCard.suffix(4))
    }
    
    private func changePurchaseStatus() {
        guard let purchase = purchase else { return }
        view?.startLoading()
        interactor?.updatePurchase(purchase: purchase).done({ [weak self] (_) in
            self?.view?.stopLoading()
        }).catch({ [weak self] (error) in
            self?.view?.stopLoading()
            self?.view?.showAlert(withTitle: error.localizedTitle, message: error.localizedDescription)
        })
    }
    
}

extension PurchaseStatus {
    
    // MARK:- Auxiliar methods
    func getTextAndColor() -> (String, UIColor) {
        switch self {
        case .waiting:
            return ("Waiting", .systemYellow)
        case .confirmed:
            return ("Confirmed", .systemOrange)
        case .inTransit:
            return ("In transit", .systemRed)
        case .received:
            return ("Received", .secondarySystemBackground)
        }
    }
    
    func getNextStatus() -> String {
        switch self {
        case .waiting:
            return "Confirm request"
        case .confirmed:
            return "Confirm item dispatched"
        case .inTransit:
            return "Confirm you received the item"
        case .received:
            return ""
        }
    }
    
}
