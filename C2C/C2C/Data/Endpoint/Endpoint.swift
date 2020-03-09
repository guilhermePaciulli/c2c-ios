//
//  Endpoint.swift
//  C2C
//
//  Created by Guilherme Paciulli on 09/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import Foundation

protocol Endpoint {
    var request: URLRequest { get }
    var method: RequestMethod { get }
    var headers: [String: String]? { get }
    var path: String { get }
    var components: URLComponents { get }
    var host: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    
    var host: String {
        return "c2c-server.herokuapp.com"
    }
    
    var components: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        components.queryItems = queryItems
        return components
    }
    
    var url: URL {
        guard let url = components.url else {
            fatalError("Error when creating URL")
        }
        return url
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var method: RequestMethod {
        return .post
    }
    
}

enum RequestMethod {
    case post, patch, get, put
    var value: String {
        switch self {
        case .post:
            return "POST"
        case .patch:
            return "PATCH"
        case .get:
            return "GET"
        case .put:
            return "PUT"
        }
    }
}
