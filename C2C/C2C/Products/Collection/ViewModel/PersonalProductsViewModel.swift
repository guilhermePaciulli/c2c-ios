//
//  PersonalProductsViewModel.swift
//  C2C
//
//  Created by Guilherme Paciulli on 08/06/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

class PersonalProductsViewModel: ProductsViewModelDelegate, ActivationDelegate {
    
    // MARK:- Properties
    weak var productsInteractor: ProductsInteractorProtocol?
    weak var userInteractor: UserInteractorProtocol?
    weak var delegate: ProductsViewControllerPresentable?
    weak var coordinator: BasicCoordinationProtocol?
    var productsList: [Product] = []
    var isLoading = false
    
    // MARK:- Delegate methods
    func getObject() {
        guard !isLoading else { return }
        isLoading = true
        if productsList.isEmpty { delegate?.startRefreshing() }
        productsInteractor?.getAll().done(on: .main, { [weak self] (productsList) in
            self?.productsList = productsList
            self?.delegate?.reloadData()
            self?.delegate?.stopLoadingInTable()
            self?.isLoading = false
        }).catch({ [weak self] (error) in
            self?.delegate?.stopLoadingInTable()
            self?.delegate?.reloadData()
            self?.delegate?.showAlert(withTitle: error.localizedTitle, message: error.localizedDescription)
            self?.isLoading = false
        })
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return productsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PersonalProductCell = tableView.dequeueReusableCell(for: indexPath)
        let product = productsList[indexPath.row].attributes
        let productPrice = "R$"+String(product.price)
        cell.setCellWith(forIndex: indexPath,
                         title: product.name,
                         withDescription: product.attributesDescription,
                         withImage: product.productImageURL,
                         andWithPrice: productPrice,
                         activated: product.activated)
        cell.delegate = self
        return cell
    }
    
    func didTapAt(indexPath: IndexPath?) {
        fatalError()
    }
    
    func shouldDisplayAddButton() -> Bool { return false }
    
    func didSelectAt(indexPath: IndexPath) { }
    
    func didTapAddButton() { }
    
}
