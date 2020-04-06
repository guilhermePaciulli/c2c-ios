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
    var coordinator: AuthenticationCoordinationProtocol?
    var view: AccountViewControllerPresentable?
    
    // MARK:- Initialization
    init(interactor: UserInteractorProtocol = UserInteractor()) {
        self.interactor = interactor
    }
    
    func fetchUser() {
        view?.startLoading()
        interactor.fetchUser().done { [weak self] in
            self?.view?.stopLoading()
            self?.view?.setName($0.name)
            self?.view?.setCPF($0.cpf)
            self?.view?.setEmail($0.email)
            self?.view?.setSurname($0.surname)
            guard let url = URL(string: $0.profile_picture_url) else { return }
            self?.view?.setProfilePicture()?.kf.setImage(with: url)
        }.catch { [weak self] (error) in
            self?.view?.stopLoading()
            self?.view?.showAlert(withTitle: error.localizedTitle, message: error.localizedDescription)
        }
    }
    
}
