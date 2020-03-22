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
    
    var path: String {
        switch self {
        case .indexProducts:
            return "/products"
        case .getProduct(let id):
            return "/products/\(id)"
        }
    }
    
    var request: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.value
        request.allHTTPHeaderFields = headers
        return request
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
    
    var method: RequestMethod {
        switch self {
        case .indexProducts:
            return .get
        case .getProduct(_):
            return .get
        }
    }
        
}
