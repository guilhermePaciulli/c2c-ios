//
//  AddressViewController.swift
//  C2C
//
//  Created by Guilherme Paciulli on 11/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

class AddressViewController: UITableViewController {

    // MARK: - Properties
    var viewModel: AddressViewModelProtocol?
    
    // MARK: - IBOutlets
    @IBOutlet weak var zipCode: UITextField?
    @IBOutlet weak var number: UITextField?
    @IBOutlet weak var complement: UITextField?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton(#selector(didTapToCancel))
        title = "Address"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchAddress()
    }
    
    // MARK: - Actions
    @IBAction func didTapToSaveAddress(_ sender: UIButton) {
        viewModel?.didTapToRegisterAddress()
    }
    
    @objc func didTapToCancel() {
        viewModel?.didTapToCancel()
    }
    

}
