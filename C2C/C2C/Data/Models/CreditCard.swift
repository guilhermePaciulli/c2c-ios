//
//  CreditCard.swift
//  C2C
//
//  Created by Guilherme Paciulli on 11/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import Foundation

struct SaveCreditCard: Codable {
    let number, cvv, owner, expiration: String
}

struct CreditCard: Codable {
    let id, type: String
    let attributes: CreditCardAttributes
}

struct CreditCardAttributes: Codable {
    let number, owner, cvv, expiration: String
}
