//
//  KeychainRepositoryMock.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 02/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import PromiseKit

class KeychainRepositoryMock: KeychainManagerProtocol {
    
    var savedKeys: [String] = []
    
    func save(key: String, data: Data) -> OSStatus {
        savedKeys.append(key)
        return 0
    }
    
    func delete(key: String) -> OSStatus {
        savedKeys.removeAll(where: { $0 == key })
        return 0
    }
    
    func load(key: String) -> Data? {
        return savedKeys.first(where: { $0 == key }) != nil ? .init() : nil
    }
    
}
