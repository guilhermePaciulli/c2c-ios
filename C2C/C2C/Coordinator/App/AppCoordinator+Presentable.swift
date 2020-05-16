//
//  AppCoordinator+Presentable.swift
//  C2C
//
//  Created by Guilherme Horcaio Paciulli on 16/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

protocol CoordinatorPresentable {
    func present(_ controller: UIViewController)
    func goTo(tab: CoordinatorType)
}


extension AppCoordinator {

    func present(_ controller: UIViewController) {
        injector.tabBarController.present(controller, animated: true)
    }
    
    func goTo(tab: CoordinatorType) {
        injector.tabBarController.selectedIndex = tab.rawValue
    }
    
}
enum CoordinatorType: Int {
    case Products = 0
    case Users = 1
}
