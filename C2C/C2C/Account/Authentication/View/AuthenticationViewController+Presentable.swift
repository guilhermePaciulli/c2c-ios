//
//  AccountViewController+Presentable.swift
//  C2C
//
//  Created by Guilherme Paciulli on 04/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

protocol AuthenticationViewControllerPresentable {
    func startLoading()
    func stopLoading()
    func showAlert(withTitle title: String, message: String)
}

extension AuthenticationViewController: AuthenticationViewControllerPresentable {
    
    func startLoading() {
        showSpinnerView()
    }
    
    func stopLoading() {
        removeSpinnerView()
    }
    
    func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            alert.dismiss(animated: true)
        }
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
}
