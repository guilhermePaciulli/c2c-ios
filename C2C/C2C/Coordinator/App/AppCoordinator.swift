//
//  AppCoordinator.swift
//  C2C
//
//  Created by Guilherme Paciulli on 08/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

class AppCoordinator {
    
    // MARK:- Properties
    var injector: AppCoordinatorDependencyInjector
    var window: UIWindow
    
    init(withWindow window: UIWindow) {
        injector = AppCoordinatorDependencyInjector()
        self.window = window
    }
    
    func start() {
        injector.navigationController.setViewControllers([injector.productsViewController], animated: false)
        window.rootViewController = injector.navigationController
        window.makeKeyAndVisible()
    }
    
}
