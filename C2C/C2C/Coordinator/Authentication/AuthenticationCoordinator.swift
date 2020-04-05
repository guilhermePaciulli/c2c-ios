//
//  AuthenticationCoordinator.swift
//  C2C
//
//  Created by Guilherme Paciulli on 04/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

class AuthenticationCoordinator: BasicCoordinationProtocol {
    
    var state: AuthenticationRoutingState = .Account
    var injector: AuthenticationDependencyInjector = .init()
    
    func presentNextStep() {
        switch state {
        case .Account:
            fatalError()
        }
    }
    
    func presentPreviousStep() {
        
    }
    
    enum AuthenticationRoutingState {
        case Account
    }
}
