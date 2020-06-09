//
//  AccountCoordinatorDependencyInjector.swift
//  C2C
//
//  Created by Guilherme Paciulli on 04/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

class AccountDependencyInjector {
    
    // MARK:- ViewControllers
    lazy var navigationController: TabBarNavigationController = {
        let navigationController = TabBarNavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.setViewControllers([accountViewController], animated: false)
        navigationController.title = "Account"
        navigationController.tabBarItem = .init(title: "Account", image: #imageLiteral(resourceName: "account"), tag: 0)
        return navigationController
    }()
    
    lazy var accountViewController: AccountViewController = {
        let controller: AccountViewController = .instantiate()
        controller.viewModel = accountViewModel
        accountViewModel.view = controller
        return controller
    }()
    
    lazy var addressViewController: AddressViewController = {
        let controller: AddressViewController = .instantiate()
        controller.viewModel = addressViewModel
        addressViewModel.view = controller
        return controller
    }()
    
    lazy var creditCardViewController: CreditCardViewController = {
        let controller: CreditCardViewController = .instantiate()
        controller.viewModel = creditCardViewModel
        creditCardViewModel.view = controller
        return controller
    }()
    
    lazy var purchaseViewController: PurchaseListViewController = {
        let controller: PurchaseListViewController = .instantiate()
        controller.viewModel = purchaseListViewModel
        purchaseListViewModel.view = controller
        return controller
    }()
    
    lazy var purchaseDetailViewController: PurchaseDetailViewController = {
        let controller: PurchaseDetailViewController = .instantiate()
        controller.viewModel = purchaseDetailViewModel
        purchaseDetailViewModel.view = controller
        return controller
    }()
    
    lazy var personalProductsViewController: ProductsViewController = {
        let controller: ProductsViewController = .instantiate()
        controller.viewModel = personalProductsViewModel
        personalProductsViewModel.view = controller
        return controller
    }()
    
    // MARK:- ViewModels
    lazy var accountViewModel: AccountViewModel = {
        let viewModel = AccountViewModel()
        viewModel.interactor = userInteractor
        return viewModel
    }()
    
    lazy var addressViewModel: AddressViewModel = {
        return .init(interactor: addressInteractor)
    }()
    
    lazy var creditCardViewModel: CreditCardViewModel = {
        return .init(interactor: creditCardInteractor)
    }()
    
    lazy var purchaseListViewModel: PurchaseListViewModel = {
        return .init(interactor: purchasesInteractor)
    }()
    
    lazy var purchaseDetailViewModel: PurchaseDetailViewModel = {
        let viewModel = PurchaseDetailViewModel()
        viewModel.interactor = purchasesInteractor
        return viewModel
    }()
    
    lazy var personalProductsViewModel: PersonalProductsViewModel = {
        let viewModel = PersonalProductsViewModel()
        viewModel.productsInteractor = productsInteractor
        return viewModel
    }()
    
    // MARK:- Interactors
    lazy var userInteractor: UserInteractor = {
        return .init()
    }()
    
    lazy var addressInteractor: AddressInteractor = {
        return .init()
    }()
    
    lazy var creditCardInteractor: CreditCardInteractor = {
        return .init()
    }()
    
    lazy var purchasesInteractor: PurchaseInteractor = {
        return .init()
    }()
    
    lazy var productsInteractor: ProductsInteractor = {
        return .init()
    }()
    
}
