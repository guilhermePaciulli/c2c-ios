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
    var productList: [Product] = []
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
        if viewModel?.shouldDisplayAddButton() ?? false {
            setupAddButton()
        }
    }
    
    // MARK:- Actions
    @objc func didPullToRefresh() {
        viewModel?.getObject()
    }
    
    @objc func didTapAddButton() {
        viewModel?.didTapAddButton()
    }
    
    @objc func didTapBackButton() {
        viewModel?.didTapBackButton()
    }
    
    // MARK:- Private methods
    private func setupView() {
        title = viewModel?.getTitle()
        tabBarController?.navigationController?.title = title
        let refresh: UIRefreshControl = .init()
        refresh.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView?.addSubview(refresh)
        refreshControl = refresh
        if viewModel?.shouldDisplayAddButton() ?? false {
            setupAddButton()
        }
        if viewModel?.shouldDisplayBackButton() ?? false {
            setBackButton(#selector(didTapBackButton))
        }
    }
    
    private func setupAddButton() {
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItem?.tintColor = .systemYellow
    }
        
}
