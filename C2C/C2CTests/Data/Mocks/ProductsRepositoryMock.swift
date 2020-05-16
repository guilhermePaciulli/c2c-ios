//
//  ProductsRepositoryMock.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 22/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import PromiseKit

class MockedProductsRespository: ProductsRepositoryProtocol {
    
    var responseError: APIResponseError?
        
    func getAll() -> Promise<[Product]> {
        return APIClientHelper(withFetchError: responseError).mockedPromiseFor(object: [Product].self)
    }
    
    func getProduct(withId id: Int) -> Promise<Product> {
        return APIClientHelper(withFetchError: responseError).mockedPromiseFor(object: Product.self)
    }
    
    func createProduct(product: CreateProduct) -> Promise<Void> {
        return APIClientHelper(withFetchError: responseError).mockedPromiseFor(object: EmptyResponse.self).map({ _ in return })
    }
}
