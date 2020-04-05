//
//  MainTabBar.swift
//  C2C
//
//  Created by Guilherme Paciulli on 05/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

class TabBarNavigationController: UINavigationController {
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    @discardableResult
    override func popViewController(animated: Bool) -> UIViewController? {
        guard viewControllers.count == 2 else { return super.popViewController(animated: animated) }
        tabBarController?.tabBar.isHidden = false
        return super.popViewController(animated: animated)
    }
    
}
