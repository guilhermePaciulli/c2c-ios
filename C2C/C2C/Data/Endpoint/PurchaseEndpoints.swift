//
//  PurchaseEndpoints.swift
//  C2C
//
//  Created by Guilherme Paciulli on 20/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import Foundation

enum PurchaseEndpoints: Endpoint {
    case purchase(product: Int)
    case purchases
    case sells
    
    var path: String {
        switch self {
        case .purchase(let id):
            return "/buy/\(id)"
        case .purchases:
            return "/purchases"
        case .sells:
            return "/sells"
        }
    }
    
    var request: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.value
        request.allHTTPHeaderFields = headers
        return request
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var method: RequestMethod {
        switch self {
        case .purchase(_):
            return .post
        case .purchases:
            return .get
        case .sells:
            return .get
        }
    }
        
}
