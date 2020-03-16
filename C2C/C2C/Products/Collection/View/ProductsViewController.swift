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
    var refreshControl: UIRefreshControl?
    
    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = self
        tableView?.delegate = self
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.getObject()
    }
    
    // MARK:- Actions
    @objc func didPullToRefresh() {
        viewModel?.getObject()
    }
    
    // MARK:- Private methods
    func setupView() {
        title = "Products"
        tabBarController?.navigationController?.title = title
        let refresh: UIRefreshControl = .init()
        refresh.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView?.addSubview(refresh)
        refreshControl = refresh
    }
        
}
