//
//  PurchaseRepository.swift
//  C2C
//
//  Created by Guilherme Paciulli on 20/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import PromiseKit

protocol PurchaseRepositoryProtocol {
    func purchase(product: Int) -> Promise<Void>
    func getPurchases(ofType type: PurchaseListingType) -> Promise<[Purchase]>
    func updatePurchase(purchase: Int) -> Promise<Void>
}


class PurchaseRepository: APIClient, PurchaseRepositoryProtocol {
    
    func purchase(product: Int) -> Promise<Void> {
        return dispatchRequest(with: PurchaseEndpoints.purchase(product: product).request, decodingType: EmptyResponse.self).map({ _ in return })
    }
    
    func getPurchases(ofType type: PurchaseListingType) -> Promise<[Purchase]> {
        if type == .sells {
            return dispatchRequest(with: PurchaseEndpoints.sells.request, decodingType: [Purchase].self)
        }
        return dispatchRequest(with: PurchaseEndpoints.purchases.request, decodingType: [Purchase].self)
    }
    
    func updatePurchase(purchase: Int) -> Promise<Void> {
        return dispatchRequest(with: PurchaseEndpoints.updatePurchase(id: purchase).request, decodingType: EmptyResponse.self).map({ _ in return })
    }
    
}

enum PurchaseListingType {
    case purchases
    case sells
}
