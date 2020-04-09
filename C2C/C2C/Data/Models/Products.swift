//
//  ProductsList.swift
//  C2C
//
//  Created by Guilherme Paciulli on 09/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

struct Product: Codable {
    let id, type: String
    let attributes: ProductAttributes
}

struct ProductAttributes: Codable {
    let id: Int
    let name, attributesDescription: String
    let price: Double
    let productImageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case attributesDescription = "description"
        case price
        case productImageURL = "product_image_url"
    }
}

struct CreateProduct: FormDatable {
    let name: String
    let description: String
    let price: String
    let picture: UIImage
    
    var parameters: [String : Any] {
        return ["name": name, "description": description, "price": price]
    }
    
    var images: [String : UIImage] {
        return ["picture": picture]
    }
    
}
