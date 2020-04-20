//
//  CreditCardRepository.swift
//  C2C
//
//  Created by Guilherme Paciulli on 11/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import PromiseKit

protocol CreditCardRepositoryProtocol {
    func create(_ address: SaveCreditCard) -> Promise<Void>
    func update(_ address: SaveCreditCard) -> Promise<Void>
    func get() -> Promise<CreditCardAttributes>
}


class CreditCardRepository: APIClient, CreditCardRepositoryProtocol {
    
    func create(_ address: SaveCreditCard) -> Promise<Void> {
        return dispatchRequest(with: CreditCardEndpoints.create(address: address).request, decodingType: CreditCard.self).map({ _ in return })
    }
    
    func update(_ address: SaveCreditCard) -> Promise<Void> {
        return dispatchRequest(with: CreditCardEndpoints.update(address: address).request, decodingType: CreditCard.self).map({ _ in return })
    }
    
    func get() -> Promise<CreditCardAttributes> {
        return dispatchRequest(with: CreditCardEndpoints.get.request, decodingType: CreditCard.self).map({ return $0.attributes })
    }
    
    
}
