//
//  AddressViewController+Presentable.swift
//  C2C
//
//  Created by Guilherme Paciulli on 11/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import Foundation

protocol AddressPresentable {
    func setField(_ field: AddressFields, withValue value: String?)
    func getField(_ field: AddressFields) -> String
    func startLoading()
    func stopLoading()
    func showAlert(withTitle title: String, message: String)
}

extension AddressViewController: AddressPresentable {
    
    func setField(_ field: AddressFields, withValue value: String?) {
        switch field {
        case .ZipCode:
            zipCode?.text = value
        case .Complement:
            complement?.text = value
        case .Number:
            number?.text = value
        }
    }
    
    func getField(_ field: AddressFields) -> String {
        switch field {
        case .ZipCode:
            return zipCode?.text ?? ""
        case .Complement:
            return complement?.text ?? ""
        case .Number:
            return number?.text ?? ""
        }
    }
    
}
