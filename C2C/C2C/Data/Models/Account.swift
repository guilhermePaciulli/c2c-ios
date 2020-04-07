//
//  Account.swift
//  C2C
//
//  Created by Guilherme Paciulli on 02/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

struct CreateAccount: FormDatable {
    let email: String
    let password: String
    let name: String
    let surname: String
    let cpf: String
    let profilePicture: UIImage
    
    var parameters: [String : Any] {
        return ["email": email, "password": password, "name": name, "surname": surname, "cpf": cpf]
    }
    
    var images: [String : UIImage] {
        return ["profile_picture": profilePicture]
    }
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

struct UserData: Codable {
    let id: String
    let type: String
    let attributes: UserDataAttributes
}

struct UserDataAttributes: Codable {
    let email: String
    let name: String
    let surname: String
    let cpf: String
    let profile_picture_url: String
}
