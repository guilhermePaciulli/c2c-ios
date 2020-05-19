//
//  PurchaseDetail+Presentable.swift
//  C2C
//
//  Created by Guilherme Paciulli on 11/05/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit
import PromiseKit

protocol PurchaseDetailPresentable {
    func showDecisionAlert(withTitle title: String, message: String) -> Promise<Void>
    func showAlert(withTitle title: String, message: String)
    func setPaymentMethodEnding(_ ending: String)
    func setZipCode(_ zipCode: String)
    func setProductName(_ name: String)
    func setProductDescription(_ value: String)
    func setProductImage() -> UIImageView?
    func setPurchaseStatus(withTitle title: String, andColor color: UIColor)
    func setStatusButtonHidden(_ hidden: Bool)
    func setPaymentMethodHidden(_ hidden: Bool)
    func setStatusButtonText(_ text: String)
    func startLoading()
    func stopLoading()
}

extension PurchaseDetailViewController: PurchaseDetailPresentable {
    
    func setPaymentMethodEnding(_ ending: String) {
        paymentMethodEnding?.text = ending
    }
    
    func setZipCode(_ zipCode: String) {
        self.zipCode?.text = zipCode
    }
    
    func setProductName(_ name: String) {
        productName?.text = name
    }
    
    func setProductDescription(_ value: String) {
        productDescription?.text = value
    }
    
    func setProductImage() -> UIImageView? {
        return productImage
    }
    
    func setPurchaseStatus(withTitle title: String, andColor color: UIColor) {
        purchaseStatus?.text = title
        purchaseStatus?.textColor = color
    }
    
    func setStatusButtonHidden(_ hidden: Bool) {
        purchaseStatusButtonCell?.isHidden = hidden
    }
    
    func setPaymentMethodHidden(_ hidden: Bool) {
        paymentMethodCell?.isHidden = hidden
    }
    
    func setStatusButtonText(_ text: String) {
        changeStatusButton?.setTitle(text, for: .normal)
    }
    
}
