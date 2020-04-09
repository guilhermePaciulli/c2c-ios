//
//  ProductsEndpoint.swift
//  C2C
//
//  Created by Guilherme Paciulli on 09/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import Foundation

enum ProductsEndpoint: Endpoint {    
    case indexProducts
    case getProduct(id: Int)
    case createProduct(product: CreateProduct)
    
    var path: String {
        switch self {
        case .indexProducts:
            return "/products"
        case .getProduct(let id):
            return "/products/\(id)"
        case .createProduct(_):
            return "products"
        }
    }
    
    var request: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.value
        request.allHTTPHeaderFields = headers
        switch self {
        case .createProduct(let body):
            request.httpBody = createFormDataFrom(model: body)
        default:
            break
        }
        return request
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
    
    var headers: [String : String]? {
        switch self {
        case .createProduct(_):
            return ["Content-Type": "multipart/form-data; boundary=\(boundary)"]
        default:
            return ["Content-Type": "application/json"]
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .indexProducts:
            return .get
        case .getProduct(_):
            return .get
        case .createProduct(_):
            return .post
        }
    }
        
}
