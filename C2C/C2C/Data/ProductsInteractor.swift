//
//  ProductsInteractor.swift
//  C2C
//
//  Created by Guilherme Paciulli on 09/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import PromiseKit

protocol ProductsInteractorProtocol: class {
    func getAll() -> Promise<Products>
}

class ProductsInteractor: ProductsInteractorProtocol {
    
    var repository: ProductsRepositoryProtocol
    
    init(repository: ProductsRepositoryProtocol = ProductsRepository()) {
        self.repository = repository
    }
    
    func getAll() -> Promise<Products> {
        return repository.getAll()
    }
    
    
}
