//
//  ProductsViewController+Presentable.swift
//  C2C
//
//  Created by Guilherme Paciulli on 09/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

protocol ProductsViewControllerPresentable: class {
    func showLoadingInTable()
    func stopLoadingInTable()
    func showAlert(withTitle title: String, andMessage message: String)
    func reloadData()
}

extension ProductsViewController: ProductsViewControllerPresentable {
    
    func showLoadingInTable() {
        // TODO
    }
    
    func stopLoadingInTable() {
        // TODO
    }
    
    func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            alert.dismiss(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func reloadData() {
        tableView?.reloadData()
    }
    
}
