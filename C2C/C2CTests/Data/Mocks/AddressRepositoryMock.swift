//
//  AddressRepositoryMock.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 11/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import PromiseKit

class AddressRepositoryMock: AddressRepositoryProtocol {
    
    var responseError: APIResponseError?

    func create(_ address: SaveAddress) -> Promise<Void> {
        return APIClientHelper.init(withFetchError: responseError).mockedPromiseFor(object: Address.self).map({ _ in return })
    }
    
    func update(_ address: SaveAddress) -> Promise<Void> {
        return APIClientHelper.init(withFetchError: responseError).mockedPromiseFor(object: Address.self).map({ _ in return })
    }
    
    func get() -> Promise<AddressAttributes> {
        return APIClientHelper.init(withFetchError: responseError).mockedPromiseFor(object: Address.self).map({ return $0.attributes })
    }
    
}
