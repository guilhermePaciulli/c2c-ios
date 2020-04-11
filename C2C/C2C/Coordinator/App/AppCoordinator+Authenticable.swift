//
//  AppCoordinator+Authenticable.swift
//  C2C
//
//  Created by Guilherme Paciulli on 05/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

protocol AppAuthenticable {
    func didLogin()
    func didLogout()
}

extension AppCoordinator {
    
    func didLogin() {
        setUpTabBar()
    }
    
    func didLogout() {
        setUpTabBar()
    }
    
}
