//
//  AuthenticationCoordinator.swift
//  C2C
//
//  Created by Guilherme Paciulli on 04/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

protocol AuthenticationCoordinationProtocol: BasicCoordinationProtocol {
    func didLogin()
}

class AuthenticationCoordinator: AuthenticationCoordinationProtocol {
    
    var state: AuthenticationRoutingState
    var injector: AuthenticationDependencyInjector
    var baseCoordinator: CoordinatorPresentable

    init(baseCoordinator: CoordinatorPresentable) {
        self.baseCoordinator = baseCoordinator
        self.state = .Authentication
        injector = .init()
        injector.authenticationViewModel.coordinator = self
    }
    
    func presentNextStep() {
        switch state {
        case .Authentication:
            state = .AccountCreation
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
            injector.navigationController.popViewController(animated: true)
        }
    }
    
    func didLogin() { }
    
    enum AuthenticationRoutingState {
        case Authentication
        case AccountCreation
    }
}