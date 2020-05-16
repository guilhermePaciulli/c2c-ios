//
//  LoginViewController.swift
//  C2C
//
//  Created by Guilherme Paciulli on 02/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController {

    // MARK:- Properties
    var viewModel: AuthenticationViewModelProtocol?
    
    // MARK:- IBOutlets
    @IBOutlet weak var popUpView: UIView?
    @IBOutlet weak var emailTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
    }
    
    // MARK:- Actions
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        viewModel?.didTapLoginButton()
    }
    
    @IBAction func didTapCreateAccountButton(_ sender: UIButton) {
        viewModel?.didTapCreateAccountButton()
    }
}
