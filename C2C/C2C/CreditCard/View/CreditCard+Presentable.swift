//
//  CreditCard+Presentable.swift
//  C2C
//
//  Created by Guilherme Paciulli on 11/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

protocol CreditCardPresentable {
    func setField(_ field: CreditCardFields, withValue value: String?)
    func getField(_ field: CreditCardFields) -> String
    func startLoading()
    func stopLoading()
    func showAlert(withTitle title: String, message: String)
    func setExpirationDate(_ date: String)
    func getExpirationDate() -> String
}

extension CreditCardViewController: CreditCardPresentable {
    
    func setExpirationDate(_ date: String) {
        let selection = expirationDateSource.getIndexes(forString: date)
        expirationDate?.selectRow(selection.month ?? 0, inComponent: 0, animated: true)
        expirationDate?.selectRow(selection.year ?? 0, inComponent: 1, animated: true)
    }
    
    func getExpirationDate() -> String {
        guard let picker = expirationDate else { return "" }
        return expirationDateSource.getDateFormatted(atMonth: picker.selectedRow(inComponent: 0), year: picker.selectedRow(inComponent: 1))
    }
    
    func setField(_ field: CreditCardFields, withValue value: String?) {
        switch field {
        case .Owner:
            owner?.text = value
        case .CVV:
            owner?.text = value
        case .Number:
            number?.text = value
        }
    }
    
    func getField(_ field: CreditCardFields) -> String {
        switch field {
        case .Owner:
            return owner?.text ?? ""
        case .CVV:
            return owner?.text ?? ""
        case .Number:
            return number?.text ?? ""
        }
    }
    
}

