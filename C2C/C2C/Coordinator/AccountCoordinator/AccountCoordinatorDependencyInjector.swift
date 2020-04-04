//
//  AccountCoordinatorDependencyInjector.swift
//  C2C
//
//  Created by Guilherme Paciulli on 04/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

class AccountCoordinatorDependencyInjector {
    
    // MARK:- ViewControllers
    lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.setViewControllers([accountViewController], animated: false)
        return navigationController
    }()
    
    lazy var authenticationViewController: AuthenticationViewController = {
        let controller: AuthenticationViewController = .instantiate()
        return controller
    }()
    
    lazy var accountViewController: AccountViewController = {
        let controller: AccountViewController = .instantiate()
        return controller
    }()
    
}
