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
        
    }
    
}
