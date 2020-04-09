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
    func didCreateProduct()
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
        }
    }
    
    func goToAddProductFlow() {
        injector.navigationController.pushViewController(injector.createProductViewController, animated: true)
    }
    
    func didCreateProduct() {
        injector.navigationController.popViewController(animated: true)
    }
    
    enum ProductsCoordinatorRoutingState {
        case ProductsList
        case ProductsDetail
    }
    
    
}
