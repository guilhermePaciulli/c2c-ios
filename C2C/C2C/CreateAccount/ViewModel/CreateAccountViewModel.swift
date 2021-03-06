//
//  CreateAccountViewModel.swift
//  C2C
//
//  Created by Guilherme Paciulli on 04/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

protocol CreateAccountViewModelProtocol {
    func didTapToCreateAccount()
    func didTapBackButton()
}

class CreateAccountViewModel: CreateAccountViewModelProtocol {
    
    // MARK:- Properties
    var interactor: UserInteractorProtocol
    var coordinator: AuthenticationCoordinationProtocol?
    var view: CreateAccountViewControllerPresentable?
    
    // MARK:- Initialization
    init(interactor: UserInteractorProtocol = UserInteractor()) {
        self.interactor = interactor
    }
    
    // MARK:- Delegate methods
    func didTapToCreateAccount() {
        guard let view = self.view else { return }
        var errors = AccountFields.allCases.compactMap({ return $0.validate(string: view.get(field: $0)) })
        if view.getProfilePicture() == nil { errors.append("You have to add a profile picture") }
        if errors.isEmpty, let acc = getAccount() {
            view.startLoading()
            interactor.createAccount(acc).done { [weak self] (_) in
                self?.coordinator?.didLogin()
                view.stopLoading()
            }.catch { (error) in
                view.stopLoading()
                view.showAlert(withTitle: error.localizedTitle, message: error.localizedDescription)
            }
        } else {
            view.showAlert(withTitle: "Invalid fields", message: errors.joined(separator: ", "))
        }
    }
    
    func didTapBackButton() {
        coordinator?.presentPreviousStep()
    }
    
    private func getAccount() -> CreateAccount? {
        guard let view = self.view else { return nil }
        return .init(email: view.get(field: .Email), password: view.get(field: .Password), name: view.get(field: .FirstName), surname: view.get(field: .Surname), cpf: view.get(field: .CPF), profilePicture: view.getProfilePicture() ?? .init())
    }
    
}
