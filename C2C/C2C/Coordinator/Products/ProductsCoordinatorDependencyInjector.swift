//
//  ProductsCoordinatorDependencyInjector.swift
//  C2C
//
//  Created by Guilherme Horcaio Paciulli on 16/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

class ProductsCoordinatorDependencyInjector {
    
    // MARK:- ViewControllers
    lazy var navigationController: TabBarNavigationController = {
        let navigationController = TabBarNavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.setViewControllers([productsViewController], animated: false)
        return navigationController
    }()
    
    lazy var productsViewController: ProductsViewController = {
        let controller: ProductsViewController = ProductsViewController.instantiate()
        controller.viewModel = productsViewModel
        productsViewModel.delegate = controller
        return controller
    }()
    
    lazy var productDetailViewController: ProductDetailViewController = {
        let controller: ProductDetailViewController = ProductDetailViewController.instantiate()
        controller.viewModel = productDetailViewModel
        productDetailViewModel.view = controller
        return controller
    }()
    
    lazy var createProductViewController: CreateProductViewController = {
        let controller: CreateProductViewController = CreateProductViewController.instantiate()
        controller.viewModel = createProductViewModel
        createProductViewModel.view = controller
        return controller
    }()
    
    
    // MARK:- ViewModels
    lazy var productsViewModel: ProductsViewModel = {
        let viewModel = ProductsViewModel()
        viewModel.interactor = productsInteractor
        viewModel.userInteractor = userInteractor
        return viewModel
    }()
    
    lazy var productDetailViewModel: ProductDetailViewModel = {
        let viewModel = ProductDetailViewModel()
        viewModel.interactor = productsInteractor
        viewModel.userInteractor = userInteractor
        viewModel.purchaseInterator = purchaseInteractor
        return viewModel
    }()
    
    lazy var createProductViewModel: CreateProductViewModel = {
        let viewModel = CreateProductViewModel()
        viewModel.interactor = productsInteractor
        return viewModel
    }()
    
    // MARK:- Interactor
    lazy var userInteractor: UserInteractorProtocol = {
        return UserInteractor()
    }()
    
    lazy var productsInteractor: ProductsInteractor = {
        return ProductsInteractor()
    }()
    
    lazy var purchaseInteractor: PurchaseInteractor = {
        return .init()
    }()
    
    // MARK:- Auxiliar functions
    func setSelectedProduct() {
        productDetailViewModel.productID = productsViewModel.selectedProduct?.id
    }
    
}
