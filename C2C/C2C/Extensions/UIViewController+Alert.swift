//
//  UIViewController+Alert.swift
//  C2C
//
//  Created by Guilherme Paciulli on 09/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit
import PromiseKit

extension UIViewController {
    
    @discardableResult
    func showAlert(withTitle title: String, message: String) -> Guarantee<Void> {
        return .init { seal in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default) { (_) in
                alert.dismiss(animated: true)
                seal(())
            }
            alert.addAction(alertAction)
            present(alert, animated: true)
        }
    }
    
    func showDecisionAlert(withTitle title: String, message: String) -> Promise<Void> {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        return .init { seal in
            let alertAction = UIAlertAction(title: "Ok", style: .destructive) { (_) in
                alert.dismiss(animated: true)
                seal.fulfill(())
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (_) in
                alert.dismiss(animated: true)
                seal.reject(ResponseError.missingUser)
            }
            alert.addAction(cancelAction)
            alert.addAction(alertAction)
            present(alert, animated: true)
        }
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
