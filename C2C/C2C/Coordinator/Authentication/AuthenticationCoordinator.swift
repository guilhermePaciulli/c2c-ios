//
//  AuthenticationCoordinator.swift
//  C2C
//
//  Created by Guilherme Paciulli on 04/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit
import PromiseKit

protocol AuthenticationCoordinationProtocol: BasicCoordinationProtocol {
    func didLogin()
}

class AuthenticationCoordinator: AuthenticationCoordinationProtocol {
    
    var state: AuthenticationRoutingState
    var injector: AuthenticationDependencyInjector
    var baseCoordinator: AppCoordinatable

    init(baseCoordinator: AppCoordinatable) {
        self.baseCoordinator = baseCoordinator
        self.state = .Authentication
        injector = .init()
        injector.authenticationViewModel.coordinator = self
    }
    
    func presentNextStep() {
        switch state {
        case .Authentication:
            state = .AccountCreation
            injector.createAccountViewModel.coordinator = self
            injector.navigationController.pushViewController(injector.createAccountViewController, animated: true)
        case .AccountCreation:
            NSLog("Trying to go further than it can")
        }
    }
    
    func presentPreviousStep() {
        switch state {
        case .Authentication:
            NSLog("Trying to return from base view ctrl")
        case .AccountCreation:
            state = .Authentication
            injector.authenticationViewModel.coordinator = self
            injector.navigationController.popViewController(animated: true)
        }
    }
    
    func didLogin() {
        self.injector.navigationController.popToRootViewController(animated: true)
        self.baseCoordinator.didLogin()
    }
    
    enum AuthenticationRoutingState {
        case Authentication
        case AccountCreation
    }
}
