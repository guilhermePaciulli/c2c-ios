//
//  CreditCardEndpoints.swift
//  C2C
//
//  Created by Guilherme Paciulli on 11/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import Foundation

enum CreditCardEndpoints: Endpoint {
    case create(address: SaveCreditCard)
    case update(address: SaveCreditCard)
    case get
    
    var path: String {
        return "/credit_card"
    }
    
    var request: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.value
        request.allHTTPHeaderFields = headers
        switch self {
        case .create(let card):
            request.httpBody = try? JSONEncoder().encode(card)
        case .update(let card):
            request.httpBody = try? JSONEncoder().encode(card)
        default:
            break;
        }
        return request
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    
    var method: RequestMethod {
        switch self {
        case .create(_):
            return .post
        case .get:
            return .get
        case .update(_):
            return .put
        }
    }
        
}
