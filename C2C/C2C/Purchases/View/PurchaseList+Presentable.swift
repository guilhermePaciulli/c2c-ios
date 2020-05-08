//
//  PurchaseList+Presentable.swift
//  C2C
//
//  Created by Guilherme Paciulli on 23/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

protocol PurchaseListPresentable {
    func startRefreshing()
    func stopLoadingInTable()
    func showAlert(withTitle title: String, message: String)
    func reloadData()
}

extension PurchaseListViewController: PurchaseListPresentable {
    
    func startRefreshing() {
        showSpinnerView(false, over: tableView)
    }
    
    func stopLoadingInTable() {
        stopLoading(false)
        refreshControl?.endRefreshing()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
}
