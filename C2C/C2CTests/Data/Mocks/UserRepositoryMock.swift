//
//  UserRepositoryMock.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 02/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import PromiseKit

class UserRepositoryMock: UserRepositoryProtocol {
    
    var responseError: APIResponseError?
    
    func createAccount(_ account: CreateAccount) -> Promise<EmptyResponse> {
        return APIClientHelper(withFetchError: responseError).mockedPromiseFor(object: EmptyResponse.self)
    }
    
    func login(_ account: LoginAccount) -> Promise<AccessToken> {
        return APIClientHelper(withFetchError: responseError).mockedPromiseFor(object: AccessToken.self)
    }
    
    func userInfo() -> Promise<UserData> {
        return APIClientHelper(withFetchError: responseError).mockedPromiseFor(object: UserData.self)
    }
    
}
