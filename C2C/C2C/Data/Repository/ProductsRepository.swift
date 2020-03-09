//
//  ProductsRepository.swift
//  C2C
//
//  Created by Guilherme Paciulli on 09/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import PromiseKit

protocol ProductsRepositoryProtocol {
    func getAll() -> Promise<Products>
}


class ProductsRepository: APIClient, ProductsRepositoryProtocol {
    
    func getAll() -> Promise<Products> {
        return dispatchRequest(with: ProductsEndpoint.getProducts.request, decodingType: Products.self)
    }
    
}
