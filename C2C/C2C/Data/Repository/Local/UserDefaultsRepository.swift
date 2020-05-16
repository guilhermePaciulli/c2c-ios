//
//  UserDefaultsRepository.swift
//  C2C
//
//  Created by Guilherme Paciulli on 06/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

protocol UserDefaultsRepositoryProtocol {
    func delete(key: UserDefaultsKeys)
    func save<T: Codable>(_ data: T, withKey key: UserDefaultsKeys)
    func fetch<T: Codable>(key: UserDefaultsKeys) -> T?
}

class UserDefaultsRepository: UserDefaultsRepositoryProtocol {
    
    func delete(key: UserDefaultsKeys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    func save<T: Codable>(_ data: T, withKey key: UserDefaultsKeys) {
        UserDefaults.standard.saveCodableToStandard(data, forKey: key.rawValue)
    }
    
    func fetch<T: Codable>(key: UserDefaultsKeys) -> T? {
        return UserDefaults.standard.getCodableFromStandard(forKey: key.rawValue)
    }
    
}

extension UserDefaults {
    
    func saveCodableToStandard<T: Codable>(_ codable: T, forKey key: String) {
        let encoded = try? JSONEncoder().encode(codable)
        UserDefaults.standard.set(encoded, forKey: key)
    }
    
    func getCodableFromStandard<T: Codable>(forKey key: String) -> T? {
        if let data = UserDefaults.standard.data(forKey: key) {
            return try? JSONDecoder().decode(T.self, from: data)
        }
        return nil
    }
}


enum UserDefaultsKeys: String, CaseIterable {
    case User
}
