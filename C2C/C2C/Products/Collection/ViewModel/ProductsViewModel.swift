//
//  ProductsViewModel.swift
//  C2C
//
//  Created by Guilherme Paciulli on 08/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

protocol ProductsViewModelDelegate {
    func getTitle() -> String
    func shouldDisplayBackButton() -> Bool
    func shouldDisplayAddButton() -> Bool
    func getObject()
    func numberOfRowsInSection(section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func didSelectAt(indexPath: IndexPath)
    func didTapAddButton()
    func didTapBackButton()
}

class ProductsViewModel: ProductsViewModelDelegate {
    
    // MARK:- Properties
    weak var interactor: ProductsInteractorProtocol?
    weak var userInteractor: UserInteractorProtocol?
    weak var delegate: ProductsViewControllerPresentable?
    weak var coordinator: ProductsCoordinationProtocol?
    var selectedProduct: ProductAttributes?
    var productsList: [Product] = []
    var isLoading = false
    
    // MARK:- Delegate methods
    func getObject() {
        guard !isLoading else { return }
        isLoading = true
        if productsList.isEmpty { delegate?.startRefreshing() }
        interactor?.getAll().done(on: .main, { [weak self] (productsList) in
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
        let cell: ProductCell = tableView.dequeueReusableCell(for: indexPath)
        let product = productsList[indexPath.row].attributes
        let productPrice = "R$"+String(product.price)
        cell.setCellWith(title: product.name,
                         withDescription: product.attributesDescription,
                         withImage: product.productImageURL,
                         andWithPrice: productPrice)
        return cell
    }
    
    func shouldDisplayAddButton() -> Bool {
        return userInteractor?.hasUser() ?? false
    }
    
    func didSelectAt(indexPath: IndexPath) {
        selectedProduct = productsList[indexPath.row].attributes
        coordinator?.presentNextStep()
    }
    
    func didTapAddButton() {
        coordinator?.goToAddProductFlow()
    }
    
    func didTapBackButton() { }
    
    func getTitle() -> String {
        return "Products"
    }
    
    func shouldDisplayBackButton() -> Bool {
        return false
    }
    
}
