//
//  AppCoordinator.swift
//  C2C
//
//  Created by Guilherme Paciulli on 08/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

protocol BasicCoordinationProtocol: class {
    func presentNextStep()
    func presentPreviousStep()
}

class AppCoordinator {
    
    // MARK:- Properties
    lazy var productsCoordinator: ProductsCoordinator = .init(baseCoordinator: self)
    lazy var accountCoordinator: AccountCoordinator = .init(baseCoordinator: self)
    var injector: AppCoordinatorDependencyInjector
    var window: UIWindow
    
    init(withWindow window: UIWindow) {
        injector = .init()
        self.window = window
    }
    
    func start() {
        setUpTabBar()
        window.rootViewController = injector.tabBarController
        window.makeKeyAndVisible()
    }
    
    private func setUpTabBar() {
        injector.tabBarController.viewControllers = [productsCoordinator.injector.navigationController,
                                                     accountCoordinator.injector.navigationController]
    }
    
}

enum CoordinatorType {
    case Products
}
