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
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return !emailPred.evaluate(with: string) ? "Email not valid" : nil
        case .Password:
            return string.count > 8 ? "Password must be greater than 8 character" : nil
        case .FirstName:
            return string.count > 4 ? "First name doesn't seem valid" : nil
        case .Surname:
            return string.count > 4 ? "First name doesn't seem valid" : nil
        case .CPF:
            let numbers = string.compactMap({ $0.wholeNumberValue })
            guard numbers.count == 11 && Set(numbers).count != 1 else { return "CPF doens't seem valid" }
            func digitCalculator(_ slice: ArraySlice<Int>) -> Int {
                var number = slice.count + 2
                let digit = 11 - slice.reduce(into: 0) {
                    number -= 1
                    $0 += $1 * number
                    } % 11
                return digit % 10
            }
            let dv1 = digitCalculator(numbers.prefix(9))
            let dv2 = digitCalculator(numbers.prefix(10))
            return !(dv1 == numbers[9] && dv2 == numbers[10]) ? "CPF doens't seem valid" : nil
        }
    }
    
}
