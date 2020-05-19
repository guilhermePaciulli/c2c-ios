//
//  PurchaseRepositoryMock.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 21/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import Foundation
@testable import C2C
import PromiseKit

class PurchaseRepositoryMock: PurchaseRepositoryProtocol {
    
    var responseError: APIResponseError?
    
    func purchase(product: Int) -> Promise<Void> {
        return APIClientHelper(withFetchError: responseError).mockedPromiseFor(object: EmptyResponse.self).map({ _ in })
    }
    
    func getPurchases(ofType type: PurchaseListingType) -> Promise<[Purchase]> {
        if type == .sells {
            return APIClientHelper(withFetchError: responseError).mockedPromiseFor(object: [Purchase].self, withFile: "Sells")
        }
        return APIClientHelper(withFetchError: responseError).mockedPromiseFor(object: [Purchase].self, withFile: "Purchases")
    }
    
    func updatePurchase(purchase: Int) -> Promise<Void> {
        fatalError()
    }
}
