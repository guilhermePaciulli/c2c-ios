//
//  AccountViewController.swift
//  C2C
//
//  Created by Guilherme Paciulli on 04/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    // MARK:- Properties
    var viewModel: AccountViewModelProtocol?

    // MARK:- IBOutlets

    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Account"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchUser()
    }

}
