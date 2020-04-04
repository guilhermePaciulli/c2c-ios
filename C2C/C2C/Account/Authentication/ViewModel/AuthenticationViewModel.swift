//
//  LoginViewModel.swift
//  C2C
//
//  Created by Guilherme Paciulli on 02/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import Foundation

protocol AuthenticationViewModelProtocol {
    func didTapLoginButton()
    func didTapCreateAccountButton()
}

class AuthenticationViewModel: AuthenticationViewModelProtocol {
    
    // MARK:- Properties
    var interactor: UserInteractor
    var coordinator: AccountCoordinatorProtocol
    var view: AuthenticationViewControllerPresentable
    
    // MARK:- Initialization
    init(interactor: UserInteractor, coordinator: AccountCoordinatorProtocol, view: AuthenticationViewControllerPresentable) {
        self.interactor = interactor
        self.coordinator = coordinator
        self.view = view
    }
    
    // MARK:- Protocol methods
    func didTapLoginButton() {
        
    }
    
    func didTapCreateAccountButton() {
        
    }
    
}
