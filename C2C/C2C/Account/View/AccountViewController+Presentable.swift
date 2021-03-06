//
//  AccountViewController+Presentable.swift
//  C2C
//
//  Created by Guilherme Paciulli on 04/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

protocol AccountViewControllerPresentable {
    func startLoading()
    func stopLoading()
    func showAlert(withTitle title: String, message: String)
    func setName(_ name: String)
    func setSurname(_ surname: String)
    func setEmail(_ email: String)
    func setCPF(_ cpf: String)
    func setProfilePicture() -> UIImageView?
}

extension AccountViewController: AccountViewControllerPresentable {
    
    func setName(_ name: String) {
        self.name?.text = name
    }
    
    func setSurname(_ surname: String) {
        self.surname?.text = surname
    }
    
    func setEmail(_ email: String) {
        self.email?.text = email
    }
    
    func setCPF(_ cpf: String) {
        self.cpf?.text = cpf
    }
    
    func setProfilePicture() -> UIImageView? {
        profilePicture?.layer.cornerRadius = (profilePicture?.frame.height ?? .zero) / 2
        profilePicture?.clipsToBounds = true
        return profilePicture
    }
    
}
