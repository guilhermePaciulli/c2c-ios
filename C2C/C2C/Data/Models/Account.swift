//
//  Account.swift
//  C2C
//
//  Created by Guilherme Paciulli on 02/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import Foundation

struct CreateAccount: Codable {
    let email: String
    let password: String
    let name: String
    let surname: String
    let cpf: String
}

struct LoginAccount: Codable {
    let email: String
    let password: String
}

struct AccessToken: Codable {
    let token: String
    enum CodingKeys: String, CodingKey {
        case token = "jwt"
    }
}

struct UserData {
    let email: String
    let name: String
    let surname: String
    let cpf: String
}
