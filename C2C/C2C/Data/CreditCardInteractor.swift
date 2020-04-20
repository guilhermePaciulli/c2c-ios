//
//  CreditCardInteractor.swift
//  C2C
//
//  Created by Guilherme Paciulli on 11/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import PromiseKit

protocol CreditCardInteractorProtocol {
    func create(_ address: SaveCreditCard) -> Promise<Void>
    func update(_ address: SaveCreditCard) -> Promise<Void>
    func get() -> Promise<CreditCardAttributes>
}


class CreditCardInteractor: APIClient, CreditCardInteractorProtocol {
    
    var repository: CreditCardRepositoryProtocol
    
    init(repository: CreditCardRepositoryProtocol = CreditCardRepository()) {
        self.repository = repository
    }
    
    func create(_ address: SaveCreditCard) -> Promise<Void> {
        return repository.create(address)
    }
    
    func update(_ address: SaveCreditCard) -> Promise<Void> {
        return repository.update(address)
    }
    
    func get() -> Promise<CreditCardAttributes> {
        return repository.get()
    }
    
}
