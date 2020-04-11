//
//  CreateAccountViewController.swift
//  C2C
//
//  Created by Guilherme Paciulli on 04/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

class CreateAccountViewController: UITableViewController {
    
    // MARK:- Properties
    var viewModel: CreateAccountViewModelProtocol?
    
    // MARK:- IBOutlets
    @IBOutlet weak var emailTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?
    @IBOutlet weak var cpfTextField: UITextField?
    @IBOutlet weak var firstNameTextField: UITextField?
    @IBOutlet weak var lastNameTextField: UITextField?
    @IBOutlet weak var profilePicture: UIImageView?
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicture?.layer.cornerRadius = (profilePicture?.frame.height ?? 0) / 2
        profilePicture?.clipsToBounds = true
        setBackButton(#selector(didTapBackButton))
        title = "Create Account"
    }

    // MARK:- Actions
    @IBAction func didTapToCreateAccount(_ sender: UIButton) {
        viewModel?.didTapToCreateAccount()
    }
    
    @IBAction func didTapToInputImage(_ sender: UITapGestureRecognizer) {
        startSelectingImage(self)
    }
    
    @objc func didTapBackButton() {
        emailTextField?.text = ""
        passwordTextField?.text = ""
        cpfTextField?.text = ""
        firstNameTextField?.text = ""
        lastNameTextField?.text = ""
        profilePicture?.image = nil
        viewModel?.didTapBackButton()
    }
}
