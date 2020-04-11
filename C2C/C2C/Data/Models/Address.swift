//
//  Address.swift
//  C2C
//
//  Created by Guilherme Paciulli on 11/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import Foundation

struct SaveAddress: Codable {
    let zipCode: String
    let complement: String
    let number: String?
    enum CodingKeys: String, CodingKey {
        case complement
        case zipCode = "zip_code"
        case number
    }
}

struct Address: Codable {
    let id, type: String
    let attributes: AddressAttributes
}

struct AddressAttributes: Codable {
    let zipCode, complement: String
    let number: String?

    enum CodingKeys: String, CodingKey {
        case zipCode = "zip_code"
        case complement
        case number
    }
}
