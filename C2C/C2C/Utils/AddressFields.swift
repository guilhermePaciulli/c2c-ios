//
//  AddressFields.swift
//  C2C
//
//  Created by Guilherme Paciulli on 11/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import Foundation

enum AddressFields: CaseIterable {
    case ZipCode
    case Complement
    case Number
    
    func validate(string: String) -> String? {
        switch self {
        case .ZipCode:
            return string.isEmpty ? "ZipCode must not be empty" : nil
        case .Complement:
            return string.isEmpty ? "Address line 2 seems invalid" : nil
        case .Number:
            if let addressNumber = Int(string) {
                return addressNumber <= 0 ? "Address number is not valid" : nil
            }
            return "address number is not valid"
        }
    }
    
}
