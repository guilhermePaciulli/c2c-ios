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
    lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
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
    
    
    // MARK:- ViewModels
    lazy var productsViewModel: ProductsViewModel = {
        let viewModel = ProductsViewModel()
        viewModel.interactor = productsInteractor
        return viewModel
    }()
    
    lazy var productDetailViewModel: ProductDetailViewModel = {
        let viewModel = ProductDetailViewModel()
        return viewModel
    }()
    
    // MARK:- Interactor
    lazy var productsInteractor: ProductsInteractor = {
        return ProductsInteractor()
    }()
    
    // MARK:- Auxiliar functions
    func setSelectedProduct() {
        productDetailViewModel.product = productsViewModel.selectedProduct
    }
    
}
