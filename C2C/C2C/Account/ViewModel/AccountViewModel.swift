//
//  AccountViewModel.swift
//  C2C
//
//  Created by Guilherme Paciulli on 04/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit
import Kingfisher

protocol AccountViewModelProtocol {
    func fetchUser()
    func didSelectRowAt(indexPath: IndexPath)
}

class AccountViewModel: AccountViewModelProtocol {
    
    // MARK:- Properties
    var interactor: UserInteractorProtocol
    var coordinator: AccountCoordinationProtocol?
    var view: AccountViewControllerPresentable?
    var selectedFlow: AccountCoordinatorRoutingState = .Account
    
    // MARK:- Initialization
    init(interactor: UserInteractorProtocol = UserInteractor()) {
        self.interactor = interactor
    }
    
    func fetchUser() {
        if let saved = interactor.savedUser() {
            setView(withUser: saved)
            return
        }
        view?.startLoading()
        interactor.fetchUser().done { [weak self] in
            self?.view?.stopLoading()
            self?.setView(withUser: $0)
        }.catch { [weak self] (error) in
            self?.view?.stopLoading()
            self?.coordinator?.userNotFound()
            self?.view?.showAlert(withTitle: error.localizedTitle, message: error.localizedDescription)
        }
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 3:
                selectedFlow = .Address
                coordinator?.presentNextStep()
            case 4:
                selectedFlow = .CreditCard
                coordinator?.presentNextStep()
            default:
                break
            }
        default:
            break
        }
    }
    
    private func setView(withUser user: UserData) {
        view?.setName(user.attributes.name)
        view?.setCPF(user.attributes.cpf)
        view?.setEmail(user.attributes.email)
        view?.setSurname(user.attributes.surname)
        guard let url = URL(string: user.attributes.profile_picture_url) else { return }
        view?.setProfilePicture()?.kf.indicatorType = .activity
        view?.setProfilePicture()?.kf.setImage(with: url)
        view?.setProfilePicture()?.backgroundColor = .clear
    }
    
}
