//
//  ProductsInteractor.swift
//  C2C
//
//  Created by Guilherme Paciulli on 09/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import PromiseKit

protocol ProductsInteractorProtocol: class {
    func getAll() -> Promise<[Product]>
    func getProduct(withId id: Int) -> Promise<Product>
    func createProduct(product: CreateProduct) -> Promise<Void>
}

class ProductsInteractor: ProductsInteractorProtocol {
    
    var repository: ProductsRepositoryProtocol
    
    init(repository: ProductsRepositoryProtocol = ProductsRepository()) {
        self.repository = repository
    }
    
    func getAll() -> Promise<[Product]> {
        return repository.getAll()
    }
    
    func getProduct(withId id: Int) -> Promise<Product> {
        return repository.getProduct(withId: id)
    }
    
    func createProduct(product: CreateProduct) -> Promise<Void> {
        return repository.createProduct(product: product)
    }
    
}
