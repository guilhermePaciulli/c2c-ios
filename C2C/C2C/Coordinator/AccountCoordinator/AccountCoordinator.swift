//
//  AccountCoordinator.swift
//  C2C
//
//  Created by Guilherme Paciulli on 04/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

protocol AccountCoordinationProtocol: BasicCoordinationProtocol {
}

class AccountCoordinator: AccountCoordinationProtocol {
    
    
    // MARK:- Properties
    var state: AccountCoordinatorRoutingState
    var injector: AccountDependencyInjector
    var baseCoordinator: CoordinatorPresentable
    
    init(baseCoordinator: CoordinatorPresentable) {
        state = .Account
        injector = .init()
        self.baseCoordinator = baseCoordinator
        injector.accountViewModel.coordinator = self
    }
    
    // MARK:- CoordinationDelegates
    func presentNextStep() {
    }
    
    func presentPreviousStep() {
    }
    
    enum AccountCoordinatorRoutingState {
        case Account
    }
    
}
