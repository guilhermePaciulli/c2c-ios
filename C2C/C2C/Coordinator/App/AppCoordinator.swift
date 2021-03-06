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

protocol AppCoordinatable: CoordinatorPresentable, AppAuthenticable { }

class AppCoordinator: AppCoordinatable {
    
    // MARK:- Properties
    lazy var productsCoordinator: ProductsCoordinator = .init(baseCoordinator: self)
    lazy var accountCoordinator: AccountCoordinator = .init(baseCoordinator: self)
    lazy var authenticationCoordinator: AuthenticationCoordinator = .init(baseCoordinator: self)
    var injector: AppCoordinatorDependencyInjector
    var window: UIWindow
    
    init(withWindow window: UIWindow) {
        injector = .init()
        self.window = window
    }
    
    func start() {
//        KeychainManager.init().delete(key: "jwt")
        setUpTabBar()
        window.rootViewController = injector.tabBarController
        window.makeKeyAndVisible()
    }
    
    internal func setUpTabBar() {
        if injector.userInteractor.hasUser() {
            injector.tabBarController.viewControllers = [productsCoordinator.injector.navigationController,
                                                         accountCoordinator.injector.navigationController]
        } else {
            injector.tabBarController.viewControllers = [productsCoordinator.injector.navigationController,
                                                         authenticationCoordinator.injector.navigationController]
        }
    }
    
}
