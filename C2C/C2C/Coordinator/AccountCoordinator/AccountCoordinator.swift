//
//  AccountCoordinator.swift
//  C2C
//
//  Created by Guilherme Paciulli on 04/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

protocol AccountCoordinationProtocol: BasicCoordinationProtocol {
    func userNotFound()
}

class AccountCoordinator: AccountCoordinationProtocol {
    
    // MARK:- Properties
    var state: AccountCoordinatorRoutingState
    var injector: AccountDependencyInjector
    var baseCoordinator: AppCoordinatable
    
    init(baseCoordinator: AppCoordinatable) {
        state = .Account
        injector = .init()
        self.baseCoordinator = baseCoordinator
        injector.accountViewModel.coordinator = self
    }
    
    // MARK:- CoordinationDelegates
    func presentNextStep() {
        switch state {
        case .Account:
            switch injector.accountViewModel.selectedFlow {
            case .Address:
                state = .Address
                injector.navigationController.pushViewController(injector.addressViewController, animated: true)
            default:
                break
            }
        case .Address:
            state = .Account
            injector.navigationController.popViewController(animated: true)
        }
    }
    
    func presentPreviousStep() {
        switch state {
        case .Account:
            NSLog("Invalid action trying to return from root view controller")
        case .Address:
            state = .Account
            injector.navigationController.popViewController(animated: true)
        }
    }
    
    func userNotFound() {
        baseCoordinator.didLogout()
    }
    
    
}
enum AccountCoordinatorRoutingState {
    case Account
    case Address
}
