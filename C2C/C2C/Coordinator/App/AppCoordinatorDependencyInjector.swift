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
    lazy var tabBarController: UITabBarController = {
        let tabBarController: UITabBarController = .init()
        tabBarController.tabBar.tintColor = .systemYellow
        return tabBarController
    }()
    
}
