//
//  ProductsViewModel.swift
//  C2C
//
//  Created by Guilherme Paciulli on 08/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

protocol ProductsViewModelDelegate {
    func getObject()
    func numberOfRowsInSection(section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
}

class ProductsViewModel: ProductsViewModelDelegate {
    
    weak var interactor: ProductsInteractorProtocol?
    weak var delegate: ProductsViewControllerPresentable?
    var productsList: [ProductsListData] = []
    
    func getObject() {
        delegate?.showLoadingInTable()
        interactor?.getAll().done(on: .main, { [weak self] (productsList) in
            self?.delegate?.stopLoadingInTable()
            self?.productsList = productsList.data
            self?.delegate?.reloadData()
        }).catch({ [weak self] (error) in
            self?.delegate?.stopLoadingInTable()
            self?.delegate?.reloadData()
            self?.delegate?.showAlert(withTitle: error.localizedTitle, andMessage: error.localizedDescription)
        })
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return productsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductCell = tableView.dequeueReusableCell(for: indexPath)
        let product = productsList[indexPath.row].attributes
        let productPrice = "R$"+String(product.price)
        cell.setCellWith(title: product.name,
                         withDescription: product.attributesDescription,
                         withImage: product.productImageURL,
                         andWithPrice: productPrice)
        return cell
    }
    
    
}
