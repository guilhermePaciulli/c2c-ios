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
    
    // MARK:- ViewModels
    lazy var accountViewModel: AccountViewModel = {
        let viewModel = AccountViewModel()
        viewModel.interactor = userInteractor
        return viewModel
    }()
    
    lazy var addressViewModel: AddressViewModel = {
        let viewModel: AddressViewModel = .init(interactor: addressInteractor)
        return viewModel
    }()
    
    // MARK:- Interactors
    lazy var userInteractor: UserInteractor = {
        return .init()
    }()
    
    lazy var addressInteractor: AddressInteractor = {
        return .init()
    }()
    
}
