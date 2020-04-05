//
//  LoginViewController.swift
//  C2C
//
//  Created by Guilherme Paciulli on 02/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    // MARK:- Properties
    
    // MARK:- IBOutlets
    @IBOutlet weak var stackView: UIStackView?
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView?.layer.cornerRadius = 16
        stackView?.clipsToBounds = true
        title = "User"
    }
    
    // MARK:- Actions
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        
    }
    
    @IBAction func didTapCreateAccountButton(_ sender: UIButton) {
    }
}
