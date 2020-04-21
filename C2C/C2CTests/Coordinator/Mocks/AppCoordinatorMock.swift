//
//  AppCoordinatorMock.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 02/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import UIKit

class AppCoordinatorMock: AppCoordinatable {
    
    var didGoToTab: CoordinatorType?
    var didLoginCalled = false
    var didLogoutCalled = false
    var presentedViewController: UIViewController?
    
    func present(_ controller: UIViewController) {
        presentedViewController = controller
    }
    
    func didLogin() {
        didLoginCalled = true
    }
    
    func didLogout() {
        didLogoutCalled = true
    }
    
    func goTo(tab: CoordinatorType) {
        didGoToTab = tab
    }
}
