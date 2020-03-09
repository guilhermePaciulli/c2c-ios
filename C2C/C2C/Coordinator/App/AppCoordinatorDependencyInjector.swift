//
//  AppCoordinatorDependencyInjector.swift
//  C2C
//
//  Created by Guilherme Paciulli on 08/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

class AppCoordinatorDependencyInjector {
    
    // MARK:- ViewControllers
    lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }()
    
    lazy var productsViewController: ProductsViewController = {
        let controller: ProductsViewController = ProductsViewController.instantiate()
        return controller
    }()
    
}
