//
//  CreditCardRepositoryMock.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 11/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import PromiseKit

class CreditCardRepositoryMock: CreditCardRepositoryProtocol {
    
    var responseError: APIResponseError?

    func create(_ address: SaveCreditCard) -> Promise<Void> {
        return APIClientHelper.init(withFetchError: responseError).mockedPromiseFor(object: CreditCard.self).map({ _ in return })
    }
    
    func update(_ address: SaveCreditCard) -> Promise<Void> {
        return APIClientHelper.init(withFetchError: responseError).mockedPromiseFor(object: CreditCard.self).map({ _ in return })
    }
    
    func get() -> Promise<CreditCardAttributes> {
        return APIClientHelper.init(withFetchError: responseError).mockedPromiseFor(object: CreditCard.self).map({ return $0.attributes })
    }
    
}
