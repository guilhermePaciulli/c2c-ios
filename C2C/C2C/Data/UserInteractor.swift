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
    func fetchUser() -> Promise<UserData>
    func hasUser() -> Bool
}

class UserInteractor: UserInteractorProtocol {
    
    
    var userRepository: UserRepositoryProtocol
    var keychainAccess: KeychainManagerProtocol
    
    init(user: UserRepositoryProtocol = UserRepository(),
         keychain: KeychainManagerProtocol = KeychainManager()) {
        userRepository = user
        keychainAccess = keychain
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
        })
    }
    
    func fetchUser() -> Promise<UserData> {
        return Promise<UserData> { seal in
            guard let jwt = keychainAccess.load(key: "jwt") else {
                throw ResponseError.missingUser
            }
            // TODO:- Fetch user
        }
        
    }
    
    func hasUser() -> Bool {
        return keychainAccess.load(key: "jwt") != nil
    }
    
}
