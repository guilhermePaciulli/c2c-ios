//
//  AddressRepository.swift
//  C2C
//
//  Created by Guilherme Paciulli on 11/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import PromiseKit

protocol AddressRepositoryProtocol {
    func create(_ address: SaveAddress) -> Promise<Void>
    func update(_ address: SaveAddress) -> Promise<Void>
    func get() -> Promise<AddressAttributes>
}


class AddressRepository: APIClient, AddressRepositoryProtocol {
    
    func create(_ address: SaveAddress) -> Promise<Void> {
        return dispatchRequest(with: AddressEndpoints.create(address: address).request, decodingType: Address.self).map({ _ in return })
    }
    
    func update(_ address: SaveAddress) -> Promise<Void> {
        return dispatchRequest(with: AddressEndpoints.update(address: address).request, decodingType: Address.self).map({ _ in return })
    }
    
    func get() -> Promise<AddressAttributes> {
        return dispatchRequest(with: AddressEndpoints.get.request, decodingType: Address.self).map({ return $0.attributes })
    }
    
    
}
