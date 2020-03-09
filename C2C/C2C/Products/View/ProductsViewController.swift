//
//  ProductsViewController.swift
//  C2C
//
//  Created by Guilherme Paciulli on 08/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {
    
    // MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView?
    
    // MARK:- Properties
    var viewModel: ProductsViewModelDelegate?
    var productList: [ProductsListData] = []
    
    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.getObject()
    }
        
}
