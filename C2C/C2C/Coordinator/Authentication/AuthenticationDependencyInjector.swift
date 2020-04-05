//
//  AuthenticationCoordinatorDependencyInjector.swift
//  C2C
//
//  Created by Guilherme Paciulli on 04/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

class AuthenticationDependencyInjector {
    
    // MARK:- ViewControllers
    lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.setViewControllers([authenticationViewController], animated: false)
        navigationController.title = "Login"
        return navigationController
    }()
    
    lazy var authenticationViewController: AuthenticationViewController = {
        let controller: AuthenticationViewController = .instantiate()
        controller.viewModel = authenticationViewModel
        authenticationViewModel.view = controller
        return controller
    }()
    
    lazy var createAccountViewController: CreateAccountViewController = {
        let controller: CreateAccountViewController = .instantiate()
        controller.viewModel = createAccountViewModel
        createAccountViewModel.view = controller
        return controller
    }()
    
    // MARK:- ViewModels
    lazy var authenticationViewModel: AuthenticationViewModel = {
        return .init(interactor: userInteractor)
    }()
    
    lazy var createAccountViewModel: CreateAccountViewModel = {
        return .init(interactor: userInteractor)
    }()
    
    // MARK:- Interactors
    lazy var userInteractor: UserInteractor = {
        return .init()
    }()
    
}
