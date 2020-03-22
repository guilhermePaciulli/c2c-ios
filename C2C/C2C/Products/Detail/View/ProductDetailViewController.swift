//
//  ProductDetailViewController.swift
//  C2C
//
//  Created by Guilherme Horcaio Paciulli on 16/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    // MARK:- IBOutlets
    @IBOutlet weak var productImage: UIImageView?
    @IBOutlet weak var productName: UILabel?
    @IBOutlet weak var productDescription: UILabel?
    @IBOutlet weak var productPrice: UILabel?
    @IBOutlet weak var exitButton: UIButton?
    @IBOutlet weak var buyButton: UIButton?
    
    // MARK:- Properties
    var viewModel: ProductDetailViewModelProtocol?
    var blurView: UIView?
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        isModalInPresentation = true
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchObject()
        exitButton?.isUserInteractionEnabled = true
        buyButton?.isUserInteractionEnabled = true
    }
    
    // MARK:- Private methods
    private func setupView() {
        buyButton?.layer.cornerRadius = 10
        buyButton?.clipsToBounds = true
    }
    
    // MARK:- LifeCycle
    @IBAction func didTapBuyButton(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        viewModel?.didTapBuyButton()
    }
    
    @IBAction func didTapExitButton(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        viewModel?.didTapExitButton()
    }
}
