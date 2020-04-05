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
    func didSelectProfilePicture(_ picture: UIImage)
}

class CreateAccountViewModel: CreateAccountViewModelProtocol {
    
    // MARK:- Properties
    var interactor: UserInteractor
    var coordinator: AuthenticationCoordinationProtocol?
    var view: CreateAccountViewControllerPresentable?
    var profilePicture: UIImage?
    
    // MARK:- Initialization
    init(interactor: UserInteractor) {
        self.interactor = interactor
    }
    
    // MARK:- Delegate methods
    func didTapToCreateAccount() {
        guard let view = self.view else { return }
        var errors = AccountFields.allCases.compactMap({ return $0.validate(string: view.get(field: $0)) })
        if profilePicture == nil { errors.append("You have to add a profile picture") }
        if errors.isEmpty, let acc = getAccount() {
            view.startLoading()
            interactor.createAccount(acc).done { [weak self] (_) in
                view.stopLoading()
                self?.coordinator?.didLogin()
            }.catch { (error) in
                view.stopLoading()
                view.showAlert(withTitle: error.localizedTitle, message: error.localizedDescription)
            }
        } else {
            view.showAlert(withTitle: "Invalid fields", message: errors.joined(separator: ", "))
        }
    }
    
    func didSelectProfilePicture(_ picture: UIImage) {
        profilePicture = picture
    }
    
    func didTapBackButton() {
        coordinator?.presentPreviousStep()
    }
    
    private func getAccount() -> CreateAccount? {
        guard let view = self.view else { return nil }
        return .init(email: view.get(field: .Email), password: view.get(field: .Password), name: view.get(field: .FirstName), surname: view.get(field: .Surname), cpf: view.get(field: .CPF))
    }
    
}
