//
//  CreditCardFields.swift
//  C2C
//
//  Created by Guilherme Paciulli on 11/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import Foundation
enum CreditCardFields: CaseIterable {
    case Number
    case Owner
    case CVV
    
    func validate(string: String) -> String? {
        switch self {
        case .Number:
            let result = CreditCardValidator.check(string: string)
            if !result.valid || result.type == .Unknown {
                return "The number doesn't seem valid"
            }
            return nil
        case .Owner:
            return string.isEmpty ? "The owner doesn't seem valid" : nil
        case .CVV:
            if Int(string) == nil || string.count != 3 {
                return "CVV is not valid"
            }
            return nil
        }
    }
}
