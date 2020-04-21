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
}


class PurchaseRepository: APIClient, PurchaseRepositoryProtocol {
    
    func purchase(product: Int) -> Promise<Void> {
        return dispatchRequest(with: PurchaseEndpoints.purchase(product: product).request, decodingType: EmptyResponse.self).map({ _ in return })
    }
    
}
