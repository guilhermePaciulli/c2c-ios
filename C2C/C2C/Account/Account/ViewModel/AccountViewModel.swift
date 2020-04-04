//
//  AccountDetailViewModel.swift
//  C2C
//
//  Created by Guilherme Paciulli on 04/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

protocol AccountViewModelProtocol {
    func fetchUser()
}

class AccountViewModel: AccountViewModelProtocol {
    
    // MARK:- Properties
    var interactor: UserInteractor
    var coordinator: BasicCoordinationProtocol
    var view: AccountViewControllerPresentable
    
    // MARK:- Initialization
    init(interactor: UserInteractor, coordinator: AccountCoordinatorProtocol, view: AccountViewControllerPresentable) {
        self.interactor = interactor
        self.coordinator = coordinator
        self.view = view
    }
    
    // MARK:- Protocol methods
    func fetchUser() {
        interactor.fetchUser().done { (userData) in
            //TODO:- Setup user view
        }.catch { [weak self] (error) in
            if case ResponseError.missingUser = error {
                self?.coordinator.presentNextStep()
                return
            }
        }
    }
    
}
