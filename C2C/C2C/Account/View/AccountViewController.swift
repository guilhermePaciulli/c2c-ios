//
//  AccountViewController.swift
//  C2C
//
//  Created by Guilherme Paciulli on 04/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

class AccountViewController: UITableViewController {
    
    // MARK:- Properties
    var viewModel: AccountViewModelProtocol?

    // MARK:- IBOutlets
    @IBOutlet weak var profilePicture: UIImageView?
    @IBOutlet weak var name: UILabel?
    @IBOutlet weak var surname: UILabel?
    @IBOutlet weak var email: UILabel?
    @IBOutlet weak var cpf: UILabel?
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = .init()
        title = "Account"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchUser()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectRowAt(indexPath: indexPath)
    }

}
