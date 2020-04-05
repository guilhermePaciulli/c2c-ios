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
    var coordinator: AuthenticationCoordinationProtocol?
    var view: AuthenticationViewControllerPresentable?
    
    // MARK:- Initialization
    init(interactor: UserInteractor) {
        self.interactor = interactor
    }
    
    // MARK:- Protocol methods
    func didTapLoginButton() {
        guard let view = self.view else { return }
        let errors = [AccountFields.Email, AccountFields.Password].compactMap({ $0.validate(string: view.get(field: $0)) })
        if errors.isEmpty {
            view.startLoading()
            interactor.login(withEmail: view.get(field: .Email), andPassword: view.get(field: .Password)).done(on: .main) { [weak self] (_) in
                view.stopLoading()
                self?.coordinator?.didLogin()
            }.catch { (error) in
                view.stopLoading()
                view.showAlert(withTitle: error.localizedTitle, message: error.localizedDescription)
            }
        } else {
            view.showAlert(withTitle: "Invalid fields", message: errors.reduce("", { "\($0), \($1)" }))
        }
        
    }
    
    func didTapCreateAccountButton() {
        coordinator?.presentNextStep()
    }
    
}
