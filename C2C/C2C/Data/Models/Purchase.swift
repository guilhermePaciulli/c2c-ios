//
//  Purchase.swift
//  C2C
//
//  Created by Guilherme Paciulli on 22/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import Foundation

struct Purchase: Decodable {
    let id, type: String
    var attributes: PurchaseAttributes
}

struct PurchaseAttributes: Decodable {
    var purchaseStatus: PurchaseStatus
    let product: DataDecodable<Product>
    let address: AddressAttributes
    let creditCard: CreditCardAttributes?

    enum CodingKeys: String, CodingKey {
        case purchaseStatus = "purchase_status"
        case product, address
        case creditCard = "credit_card"
    }
}

enum PurchaseStatus: String, Codable {
    case waiting
    case confirmed
    case inTransit = "in_transit"
    case received
}

struct UpdatedPurchaseStatus: Decodable {
    let purchaseStatus: PurchaseStatus
    
    enum CodingKeys: String, CodingKey {
        case purchaseStatus = "purchase_status"
    }
}
