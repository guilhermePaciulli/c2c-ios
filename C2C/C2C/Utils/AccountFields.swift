//
//  AccountFields.swift
//  C2C
//
//  Created by Guilherme Paciulli on 04/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import Foundation

enum AccountFields: CaseIterable {
    case Email
    case Password
    case FirstName
    case Surname
    case CPF
    
    func validate(string: String) -> String? {
        switch self {
        case .Email:
            return !string.isEmail ? "Email not valid" : nil
        case .Password:
            return string.count < 8 ? "Password must be greater than 8 character" : nil
        case .FirstName:
            return string.count < 4 ? "First name doesn't seem valid" : nil
        case .Surname:
            return string.count < 4 ? "First name doesn't seem valid" : nil
        case .CPF:
            return !string.isCPF ? "CPF doens't seem valid" : nil
        }
    }
    
}
