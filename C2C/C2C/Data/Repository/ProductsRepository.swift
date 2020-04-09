//
//  ProductsRepository.swift
//  C2C
//
//  Created by Guilherme Paciulli on 09/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import PromiseKit

protocol ProductsRepositoryProtocol {
    func getAll() -> Promise<[Product]>
    func getProduct(withId id: Int) -> Promise<Product>
    func createProduct(product: CreateProduct) -> Promise<Void>
}


class ProductsRepository: APIClient, ProductsRepositoryProtocol {
    
    func getAll() -> Promise<[Product]> {
        return dispatchRequest(with: ProductsEndpoint.indexProducts.request, decodingType: [Product].self)
    }
    
    func getProduct(withId id: Int) -> Promise<Product> {
        return dispatchRequest(with: ProductsEndpoint.getProduct(id: id).request, decodingType: Product.self)
    }
    
    func createProduct(product: CreateProduct) -> Promise<Void> {
        return dispatchRequest(with: ProductsEndpoint.createProduct(product: product).request, decodingType: Product.self).map({ _ in return })
    }
    
}
