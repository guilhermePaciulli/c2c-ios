//
//  AddressEndpoints.swift
//  C2C
//
//  Created by Guilherme Paciulli on 11/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import Foundation

enum AddressEndpoints: Endpoint {
    case create(address: SaveAddress)
    case update(address: SaveAddress)
    case get
    
    var path: String {
        return "/addresses"
    }
    
    var request: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.value
        request.allHTTPHeaderFields = headers
        switch self {
        case .create(let addr):
            request.httpBody = try? JSONEncoder().encode(addr)
        case .update(let addr):
            request.httpBody = try? JSONEncoder().encode(addr)
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
