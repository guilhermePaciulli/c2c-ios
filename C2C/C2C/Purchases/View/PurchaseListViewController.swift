//
//  PurchaseListViewController.swift
//  C2C
//
//  Created by Guilherme Paciulli on 22/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

class PurchaseListViewController: UITableViewController {
    
    // MARK:- Properties
    var viewModel: PurchaseListViewModelProtocol?
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton(#selector(didTapBackButton))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchPurchases()
    }
    
    // MARK:- Actions
    @objc func didTapBackButton() {
        viewModel?.didTapBackButton()
    }

}
