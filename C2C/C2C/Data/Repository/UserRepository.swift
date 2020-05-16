//
//  UserRepository.swift
//  C2C
//
//  Created by Guilherme Paciulli on 02/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import PromiseKit

protocol UserRepositoryProtocol {
    func createAccount(_ account: CreateAccount) -> Promise<EmptyResponse>
    func login(_ account: LoginAccount) -> Promise<AccessToken>
    func userInfo() -> Promise<UserData>
}


class UserRepository: APIClient, UserRepositoryProtocol {
    
    func createAccount(_ account: CreateAccount) -> Promise<EmptyResponse> {
        return dispatchRequest(with: UserEndpoints.createAcount(account: account).request, decodingType: EmptyResponse.self)
    }
    
    func login(_ account: LoginAccount) -> Promise<AccessToken> {
        return dispatchRequest(with: UserEndpoints.login(account: account).request, decodingType: AccessToken.self)
    }
    
    func userInfo() -> Promise<UserData> {
        return dispatchRequest(with: UserEndpoints.userInfo.request, decodingType: UserData.self)
    }
    
}
