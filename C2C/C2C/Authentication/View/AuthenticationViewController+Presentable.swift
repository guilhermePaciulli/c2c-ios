//
//  AccountViewController+Presentable.swift
//  C2C
//
//  Created by Guilherme Paciulli on 04/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

protocol AuthenticationViewControllerPresentable {
    func startLoading(_ hidingUIElements: Bool)
    func stopLoading(_ hidingUIElements: Bool)
    func showAlert(withTitle title: String, message: String)
    func get(field: AccountFields) -> String
}

extension AuthenticationViewController: AuthenticationViewControllerPresentable {
    
    func get(field: AccountFields) -> String {
        switch field {
        case .Email:
            return emailTextField?.text ?? ""
        case .Password:
            return passwordTextField?.text ?? ""
        default:
            return ""
        }
    }
    
}
