//
//  PurchaseInteractor.swift
//  C2C
//
//  Created by Guilherme Paciulli on 20/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import PromiseKit

protocol PurchaseInteractorProtocol {
    func purchase(product: ProductAttributes) -> Promise<Void>
}


class PurchaseInteractor: APIClient, PurchaseInteractorProtocol {
    
    var repository: PurchaseRepositoryProtocol
    
    init(repository: PurchaseRepositoryProtocol = PurchaseRepository()) {
        self.repository = repository
    }
    
    func purchase(product: ProductAttributes) -> Promise<Void> {
        return repository.purchase(product: product.id)
    }
    
}
