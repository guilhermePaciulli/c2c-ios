//
//  PurchaseDetailViewController.swift
//  C2C
//
//  Created by Guilherme Paciulli on 11/05/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

class PurchaseDetailViewController: UITableViewController {
    
    // MARK:- Properties
    weak var viewModel: PurchaseDetailViewModelProtocol?
    
    // MARK:- IBOutlets
    @IBOutlet weak var productImage: UIImageView?
    @IBOutlet weak var productName: UILabel?
    @IBOutlet weak var productDescription: UILabel?
    @IBOutlet weak var paymentMethodEnding: UILabel?
    @IBOutlet weak var zipCode: UILabel?
    @IBOutlet weak var purchaseStatus: UILabel?
    @IBOutlet weak var changeStatusButton: UIButton?
    @IBOutlet weak var purchaseStatusButtonCell: UITableViewCell?
    @IBOutlet weak var paymentMethodCell: UITableViewCell?
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewWillAppear()
        title = viewModel?.getViewName()
    }
    
    // MARK:- Private methods
    private func setupView() {
        changeStatusButton?.layer.cornerRadius = 10
        changeStatusButton?.clipsToBounds = true
        setBackButton(#selector(didTapBackButton))
    }
    
    // MARK:- Actions
    @IBAction func didTapToChangePurchaseStatus(_ sender: UIButton) {
        viewModel?.didTapToChangePurchaseStatus()
    }
    
    @objc func didTapBackButton() {
        viewModel?.didTapBackButton()
    }

}
