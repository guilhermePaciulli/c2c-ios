//
//  CreateAccountViewController+Presentable.swift
//  C2C
//
//  Created by Guilherme Paciulli on 04/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

protocol CreateAccountViewControllerPresentable {
    func startLoading()
    func stopLoading()
    func showAlert(withTitle title: String, message: String)
    func get(field: AccountFields) -> String
    func getProfilePicture() -> UIImage?
}

extension CreateAccountViewController: CreateAccountViewControllerPresentable {
    
    func get(field: AccountFields) -> String {
        switch field {
        case .Email:
            return emailTextField?.text ?? ""
        case .Password:
            return passwordTextField?.text ?? ""
        case .CPF:
            return cpfTextField?.text ?? ""
        case .FirstName:
            return firstNameTextField?.text ?? ""
        case .Surname:
            return lastNameTextField?.text ?? ""
        }
    }
    
    func getProfilePicture() -> UIImage? {
        return profilePicture?.image
    }
    
}
