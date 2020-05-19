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
}

class PurchaseDetailViewModel: PurchaseDetailViewModelProtocol {
    
    // MARK:- Properties
    var view: PurchaseDetailPresentable?
    var purchase: PurchaseAttributes?
    var coordinator: BasicCoordinationProtocol?
    var interactor: PurchaseInteractorProtocol?
    
    // MARK:- Protocol methods
    func viewWillAppear() {
        guard let purchase = purchase,
            let imgURL = URL(string: purchase.product.data.attributes.productImageURL) else { coordinator?.presentPreviousStep(); return; }
        
        view?.setZipCode(purchase.address.zipCode)
        view?.setProductName(purchase.product.data.attributes.name)
        view?.setProductDescription(purchase.product.data.attributes.attributesDescription)
        view?.setProductImage()?.kf.setImage(with: imgURL)
        let status = purchase.purchaseStatus.getTextAndColor()
        view?.setPurchaseStatus(withTitle: status.0, andColor: status.1)
        
        view?.setPaymentMethodHidden(isSellerPurchase())
        view?.setStatusButtonHidden(!shouldShowStatusButton())
        view?.setPaymentMethodEnding(getPaymentMethodEnding())
    }
    
    func didTapToChangePurchaseStatus() {
        fatalError()
    }
    
    func didTapBackButton() {
        coordinator?.presentPreviousStep()
    }
    
    // MARK:- Private methods
    private func isSellerPurchase() -> Bool {
        return purchase?.creditCard == nil
    }
    
    private func shouldShowStatusButton() -> Bool {
        guard let purchase = purchase else { return false }
        return purchase.purchaseStatus == .inTransit ||
            (isSellerPurchase() && purchase.purchaseStatus != .inTransit)
    }
    
    private func getPaymentMethodEnding() -> String {
        guard let creditCard = purchase?.creditCard?.number else { return "" }
        return String(creditCard.suffix(4))
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
    
}
