//
//  ProductsViewController+Presentable.swift
//  C2C
//
//  Created by Guilherme Paciulli on 09/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

protocol ProductsViewControllerPresentable: class {
    func startRefreshing()
    func stopLoadingInTable()
    func showAlert(withTitle title: String, message: String)
    func reloadData()
}

extension ProductsViewController: ProductsViewControllerPresentable {
    
    func startRefreshing() {
        showSpinnerView(false, over: tableView)
    }
    
    func stopLoadingInTable() {
        stopLoading(false)
        refreshControl?.endRefreshing()
    }
    
    func reloadData() {
        tableView?.reloadData()
    }
    
}
