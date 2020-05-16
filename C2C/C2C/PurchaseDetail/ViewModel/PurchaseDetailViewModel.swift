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
}

class PurchaseDetailViewModel: PurchaseDetailViewModelProtocol {
    
    // MARK:- Properties
    var view: PurchaseDetailPresentable?
    var purchase: Purchase?
    var coordinator: BasicCoordinationProtocol?
    var interactor: PurchaseInteractorProtocol?
    
    // MARK:- Protocol methods
    func viewWillAppear() {
        guard let purchase = purchase,
            let imgURL = URL(string: purchase.attributes.product.data.attributes.productImageURL) else { coordinator?.presentPreviousStep(); return; }
        
        view?.setZipCode(purchase.attributes.address.zipCode)
        view?.setProductName(purchase.attributes.product.data.attributes.name)
        view?.setProductImage()?.kf.setImage(with: imgURL)
        let status = purchase.attributes.purchaseStatus.getTextAndColor()
        view?.setPurchaseStatus(withTitle: status.0, andColor: status.1)
        
        view?.setPaymentMethodHidden(isSellerPurchase())
        view?.setStatusButtonHidden(!shouldShowStatusButton())
        view?.setPaymentMethodEnding(getPaymentMethodEnding())
    }
    
    func didTapToChangePurchaseStatus() {
        fatalError()
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
        guard let creditCard = purchase?.attributes.creditCard?.number.reversed() else { return "" }
        return String(creditCard.prefix(4))
    }
    
}

extension PurchaseStatus {
    
    // MARK:- Auxiliar methods
    func getTextAndColor() -> (String, UIColor) {
        switch self {
        case .waiting:
            return ("Waiting", .systemYellow)
        case .confirmed:
            return ("Confirmed", .systemGreen)
        case .inTransit:
            return ("In transit", .black)
        case .received:
            return ("Received", .secondarySystemBackground)
        }
        
    }
    
}
