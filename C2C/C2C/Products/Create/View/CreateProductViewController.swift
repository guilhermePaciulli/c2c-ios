//
//  CreateProductTableViewController.swift
//  C2C
//
//  Created by Guilherme Paciulli on 08/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

class CreateProductViewController: UITableViewController {
    
    // MARK:- IBOutlets
    @IBOutlet weak var productImage: UIImageView?
    @IBOutlet weak var productName: UITextField?
    @IBOutlet weak var productDescription: UITextView?
    @IBOutlet weak var productPrice: UITextField?
    
    // MARK:- LifeCycle
    var viewModel: CreateProductViewModelProtocol?
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton(#selector(didTapBackButton))
        title = "Create product"
    }
    
    // MARK:- Actions
    @objc func didTapBackButton() {
        viewModel?.didTapBackButton()
        productName?.text = ""
        productImage?.image = UIImage(named: "stub_product")
        productImage?.contentMode = .scaleAspectFit
        productDescription?.text = "Insert your description here"
        productPrice?.text = ""
    }
    
    @IBAction func didTapCreateProduct(_ sender: UIButton) {
        viewModel?.didTapCreateProduct()
    }
}
