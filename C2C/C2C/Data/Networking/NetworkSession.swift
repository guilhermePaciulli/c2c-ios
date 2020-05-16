//
//  NetworkSession.swift
//  C2C
//
//  Created by Guilherme Paciulli on 06/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit
import PromiseKit

class NetworkSession {
    
    private var session: URLSession
    var keychainManager: KeychainManagerProtocol
    
    init() {
        keychainManager = KeychainManager()
        session = .shared
    }
    
    var additionalHeaders: [AnyHashable: Any] {
        return ["Authorization": String(data: keychainManager.load(key: "jwt") ?? .init(), encoding: .utf8) ?? ""]
    }
    
    func buildSession() -> URLSession {
        let config: URLSessionConfiguration = .default
        config.httpAdditionalHeaders = additionalHeaders
        return .init(configuration: config)
    }
    
}
