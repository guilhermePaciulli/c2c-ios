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
                injector.addressViewModel.coordinator = self
                injector.navigationController.pushViewController(injector.addressViewController, animated: true)
            case .CreditCard:
                state = .CreditCard
                injector.creditCardViewModel.coordinator = self
                injector.navigationController.pushViewController(injector.creditCardViewController, animated: true)
            case .Purchases(let type):
                state = .Purchases(type: type)
                injector.purchaseListViewModel.type = type
                injector.purchaseListViewModel.coordinator = self
                injector.navigationController.pushViewController(injector.purchaseViewController, animated: true)
            default:
                break
            }
        case .Address:
            state = .Account
            injector.navigationController.popViewController(animated: true)
        case .CreditCard:
            state = .Account
            injector.navigationController.popViewController(animated: true)
        case .Purchases(_):
            // TODO:- Add purchase details here
            break
        }
    }
    
    func presentPreviousStep() {
        switch state {
        case .Account:
            NSLog("Invalid action trying to return from root view controller")
        default:
            state = .Account
            injector.navigationController.popViewController(animated: true)
        }
    }
    
    func userNotFound() {
        baseCoordinator.didLogout()
    }
    
    
}
enum AccountCoordinatorRoutingState: Equatable {
    case Account
    case Address
    case CreditCard
    case Purchases(type: PurchaseListingType)
}
