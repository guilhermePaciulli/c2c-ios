//
//  AddressInteractor.swift
//  C2C
//
//  Created by Guilherme Paciulli on 11/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import PromiseKit

protocol AddressInteractorProtocol {
    func create(_ address: SaveAddress) -> Promise<Void>
    func update(_ address: SaveAddress) -> Promise<Void>
    func get() -> Promise<AddressAttributes>
}


class AddressInteractor: APIClient, AddressInteractorProtocol {
    
    var repository: AddressRepositoryProtocol
    
    init(repository: AddressRepositoryProtocol = AddressRepository()) {
        self.repository = repository
    }
    
    func create(_ address: SaveAddress) -> Promise<Void> {
        return repository.create(address)
    }
    
    func update(_ address: SaveAddress) -> Promise<Void> {
        return repository.update(address)
    }
    
    func get() -> Promise<AddressAttributes> {
        return repository.get()
    }
    
}
