//
//  UserDefaultsRepositoryMock.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 06/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import UIKit

class UserDefaultsRepositoryMock: UserDefaultsRepositoryProtocol {
    
    var userDefaultsDictionary: [UserDefaultsKeys: Codable] = [:]
    var shouldReturnValue = true
    var didSaveValue: UserDefaultsKeys?
    
    func delete(key: UserDefaultsKeys) {
        userDefaultsDictionary[.User] = nil
    }

    func save<T>(_ data: T, withKey key: UserDefaultsKeys) where T : Decodable, T : Encodable {
        didSaveValue = key
    }

    func fetch<T>(key: UserDefaultsKeys) -> T? where T : Decodable, T : Encodable {
        if shouldReturnValue {
            switch key {
            case .User:
                guard let data = FilesHelper.loadFileAsData(T.self),
                    let userData = try? JSONDecoder().decode(DataDecodable<T>.self, from: data) else { return nil }
                return userData.data
            }
        }
        return nil
    }
    
}
