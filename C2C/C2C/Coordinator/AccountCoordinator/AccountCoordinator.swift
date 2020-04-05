//
//  AccountCoordinator.swift
//  C2C
//
//  Created by Guilherme Paciulli on 04/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

protocol AccountCoordinatorProtocol: BasicCoordinationProtocol {
    func didTapCreateAccount()
    func didLoginSuccessfully()
}

class AccountCoordinator: AccountCoordinatorProtocol {
    
    
    // MARK:- Properties
    var state: AccountCoordinatorRoutingState
    var injector: AccountDependencyInjector
    var baseCoordinator: CoordinatorPresentable
    
    init(baseCoordinator: CoordinatorPresentable) {
        state = .Account
        injector = .init()
        self.baseCoordinator = baseCoordinator
    }
    
    // MARK:- CoordinationDelegates
    func presentNextStep() {
    }
    
    func presentPreviousStep() {
    }
    
    func didTapCreateAccount() {
        
    }
    
    func didLoginSuccessfully() {
        
    }
    
    enum AccountCoordinatorRoutingState {
        case Account
    }
    
}
