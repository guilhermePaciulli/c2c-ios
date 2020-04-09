//
//  ProductsCoordinator.swift
//  C2C
//
//  Created by Guilherme Horcaio Paciulli on 16/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import Foundation

protocol ProductsCoordinationProtocol: BasicCoordinationProtocol {
    func goToAddProductFlow()
}

class ProductsCoordinator: ProductsCoordinationProtocol {
    
    // MARK:- Properties
    var state: ProductsCoordinatorRoutingState
    var injector: ProductsCoordinatorDependencyInjector
    var baseCoordinator: CoordinatorPresentable
    
    init(baseCoordinator: CoordinatorPresentable) {
        state = .ProductsList
        injector = .init()
        self.baseCoordinator = baseCoordinator
        injector.productsViewModel.coordinator = self
    }
    
    // MARK:- CoordinationDelegates
    func presentNextStep() {
        switch state {
        case .ProductsList:
            state = .ProductsDetail
            injector.setSelectedProduct()
            injector.productDetailViewModel.coordinator = self
            baseCoordinator.present(injector.productDetailViewController)
        case .ProductsDetail:
            fatalError()
        case .CreateProduct:
            injector.navigationController.popViewController(animated: true)
        }
    }
    
    func presentPreviousStep() {
        switch state {
        case .ProductsList:
            NSLog("Error: trying to return from root at ProductsCoordinator")
        case .ProductsDetail:
            state = .ProductsList
            injector.productsViewModel.coordinator = self
            injector.productDetailViewController.dismiss(animated: true)
        case .CreateProduct:
            injector.navigationController.popViewController(animated: true)
        }
    }
    
    func goToAddProductFlow() {
        state = .CreateProduct
        injector.navigationController.pushViewController(injector.createProductViewController, animated: true)
    }
    
    enum ProductsCoordinatorRoutingState {
        case ProductsList
        case ProductsDetail
        case CreateProduct
    }
    
    
}
