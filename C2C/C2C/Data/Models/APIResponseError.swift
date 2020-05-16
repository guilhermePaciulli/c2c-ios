//
//  APIResponseError.swift
//  C2C
//
//  Created by Guilherme Paciulli on 09/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import Foundation

struct APIResponseError: Codable {
    let message: String
}

enum ResponseError: Error {
    case api(error: APIResponseError)
    case timeout
    case jsonConversionFailure
    case server
    case missingInstance
    case missingUser
    
    var localizedTitle: String {
        switch self {
        case .jsonConversionFailure:
            return "Error"
        case .api(_):
            return "Request error"
        case .timeout:
            return "Timeout"
        case .server:
            return "Server error"
        case .missingInstance:
            return "Internal error"
        case .missingUser:
            return "No user found"
        }
    }
    
    var localizedDescription: String {
        switch self {
        case .jsonConversionFailure:
            return "Internal error"
        case .missingInstance:
            return "We all make mistakes..."
        case .timeout:
            return "You seem to be offline."
        case .server:
            return "There was an internal error in our servers"
        case .missingUser:
            return "You have to login in order to proceed with this action"
        case .api(let error):
            return error.message
        }
        
    }
    
}
