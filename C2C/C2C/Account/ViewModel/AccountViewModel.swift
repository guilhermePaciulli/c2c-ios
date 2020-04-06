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
}

class AccountViewModel: AccountViewModelProtocol {
    
    // MARK:- Properties
    var interactor: UserInteractorProtocol
    var coordinator: AccountCoordinationProtocol?
    var view: AccountViewControllerPresentable?
    
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
            self?.userNotFoundError()
            self?.view?.showAlert(withTitle: error.localizedTitle, message: error.localizedDescription)
        }
    }
    
    private func setView(withUser user: UserData) {
        view?.setName(user.attributes.name)
        view?.setCPF(user.attributes.cpf)
        view?.setEmail(user.attributes.email)
        view?.setSurname(user.attributes.surname)
        guard let url = URL(string: user.attributes.profile_picture_url) else { return }
        view?.setProfilePicture()?.kf.setImage(with: url)
        view?.setProfilePicture()?.backgroundColor = .clear
    }
    
    private func userNotFoundError() {
        view?.setName("Error fetching user")
        view?.setCPF("")
        view?.setEmail("")
        view?.setSurname("Try again later")
        view?.setProfilePicture()?.image = UIImage(named: "stub_profile")
        view?.setProfilePicture()?.backgroundColor = .systemYellow
    }
    
}
