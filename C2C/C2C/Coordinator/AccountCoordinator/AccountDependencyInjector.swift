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
        return controller
    }()
    
}
