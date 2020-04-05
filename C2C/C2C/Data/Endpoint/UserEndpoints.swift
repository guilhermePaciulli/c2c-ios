//
//  UserEndpoints.swift
//  C2C
//
//  Created by Guilherme Paciulli on 02/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import Foundation

enum UserEndpoints: Endpoint {
    case login(account: LoginAccount)
    case createAcount(account: CreateAccount)
    
    var path: String {
        switch self {
        case .login:
            return "/user_token"
        case .createAcount:
            return "/users"
        }
    }
    var request: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.value
        request.allHTTPHeaderFields = headers
        switch self {
        case .login(let body):
            request.httpBody = try? JSONEncoder().encode(body)
        case .createAcount(let body):
            request.httpBody = createFormDataFrom(model: body)
        }
        return request
    }
    
    var headers: [String : String]? {
        switch self {
        case .createAcount(_):
            return ["Content-Type": "multipart/form-data; boundary=\(boundary)"]
        case .login(_):
            return ["Content-Type": "application/json"]
        }
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
    
    var method: RequestMethod {
        switch self {
        case .login:
            return .post
        case .createAcount:
            return .post
        }
    }
        
}
