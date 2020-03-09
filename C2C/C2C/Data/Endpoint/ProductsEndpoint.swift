//
//  ProductsEndpoint.swift
//  C2C
//
//  Created by Guilherme Paciulli on 09/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import Foundation

enum ProductsEndpoint: Endpoint {    
    case getProducts
    
    var path: String {
        switch self {
        case .getProducts:
            return "/products"
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
        case .getProducts:
            return .get
        }
    }
        
}
