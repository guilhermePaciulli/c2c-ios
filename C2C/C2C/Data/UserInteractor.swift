//
//  UserInteractor.swift
//  C2C
//
//  Created by Guilherme Paciulli on 02/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import PromiseKit

protocol UserInteractorProtocol: class {
    func createAccount(_ account: CreateAccount) -> Promise<Void>
    func login(withEmail email: String, andPassword password: String) -> Promise<Void>
    func savedUser() -> UserData?
    func fetchUser() -> Promise<UserData>
    func hasUser() -> Bool
}

class UserInteractor: UserInteractorProtocol {
    
    var userRepository: UserRepositoryProtocol
    var keychainAccess: KeychainManagerProtocol
    var userDefaultsRepository: UserDefaultsRepositoryProtocol
    
    init(user: UserRepositoryProtocol = UserRepository(),
         keychain: KeychainManagerProtocol = KeychainManager(),
         userDefaults: UserDefaultsRepositoryProtocol = UserDefaultsRepository()) {
        userRepository = user
        keychainAccess = keychain
        userDefaultsRepository = userDefaults
    }
    
    func createAccount(_ account: CreateAccount) -> Promise<Void> {
        return userRepository.createAccount(account).then { (_) -> Promise<Void> in
            return self.login(withEmail: account.email, andPassword: account.password)
        }
    }
    
    func login(withEmail email: String, andPassword password: String) -> Promise<Void> {
        return userRepository.login(.init(email: email, password: password)).map({ [weak self] token in
            self?.keychainAccess.save(key: "jwt", data: token.token.data(using: .utf8) ?? .init())
            return
        }).then { _ -> Promise<UserData> in
            return self.fetchUser()
        }.map { (userData) -> Void in
            self.userDefaultsRepository.save(userData, withKey: .User)
            return
        }
    }
    
    func savedUser() -> UserData? {
        return userDefaultsRepository.fetch(key: .User)
    }
    
    func fetchUser() -> Promise<UserData> {
        return self.userRepository.userInfo()
    }
    
    func hasUser() -> Bool {
        return keychainAccess.load(key: "jwt") != nil
    }
    
}
