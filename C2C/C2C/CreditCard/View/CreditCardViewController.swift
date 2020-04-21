//
//  CreditCardViewController.swift
//  C2C
//
//  Created by Guilherme Paciulli on 11/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

class CreditCardViewController: UITableViewController {

    // MARK: - Properties
    var viewModel: CreditCardViewModelProtocol?
    var expirationDateSource = ExpirationDateComponents()
    
    // MARK: - IBOutlets
    @IBOutlet weak var number: UITextField?
    @IBOutlet weak var owner: UITextField?
    @IBOutlet weak var cvv: UITextField?
    @IBOutlet weak var expirationDate: UIPickerView?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton(#selector(didTapToCancel))
        title = "Credit Card"
        expirationDate?.delegate = self
        expirationDate?.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchCreditCard()
    }
    
    // MARK: - Actions
    @IBAction func didTapToSaveCreditCard(_ sender: UIButton) {
        viewModel?.didTapToRegisterCreditCard()
    }
    
    @objc func didTapToCancel() {
        viewModel?.didTapToCancel()
    }

}
