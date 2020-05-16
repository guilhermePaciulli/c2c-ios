//
//  ProductFields.swift
//  C2C
//
//  Created by Guilherme Paciulli on 08/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import Foundation

enum ProductFields: CaseIterable {
    case Name
    case Description
    case Price
    
    func validate(string: String) -> String? {
        switch self {
        case .Name:
            return string.isEmpty ? "Name must not be empty" : nil
        case .Description:
            return string.isEmpty ? "Description must not be empty" : nil
        case .Price:
            if let price = Int(string) {
                return price <= 0 ? "Price must be greater than zero" : nil
            }
            return "Price is not valid"
        }
    }
    
}
