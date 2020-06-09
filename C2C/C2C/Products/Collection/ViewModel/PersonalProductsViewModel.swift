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
    weak var view: ProductsViewControllerPresentable?
    weak var coordinator: BasicCoordinationProtocol?
    var personalProductsList: [Product] = []
    var isLoading = false
    
    // MARK:- Delegate methods
    func getObject() {
        guard !isLoading else { return }
        isLoading = true
        if personalProductsList.isEmpty { view?.startRefreshing() }
        productsInteractor?.getPersonalAds().done(on: .main, { [weak self] (productsList) in
            self?.personalProductsList = productsList
            self?.view?.reloadData()
            self?.view?.stopLoadingInTable()
            self?.isLoading = false
        }).catch({ [weak self] (error) in
            self?.view?.stopLoadingInTable()
            self?.view?.reloadData()
            self?.view?.showAlert(withTitle: error.localizedTitle, message: error.localizedDescription)
            self?.isLoading = false
        })
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return personalProductsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let personalProductCell: PersonalProductCell = tableView.dequeueReusableCell(for: indexPath)
        let product = personalProductsList[indexPath.row].attributes
        personalProductCell.setCellWith(forIndex: indexPath,
                                        title: product.name,
                                        withImage: product.productImageURL,
                                        activated: product.activated)
        personalProductCell.delegate = self
        return personalProductCell
    }
    
    func didTapAt(indexPath: IndexPath?) {
        guard let index = indexPath else { return }
        view?.startRefreshing()
        productsInteractor?.activation(personalProductsList[index.row]).done({ [weak self] (_) in
            self?.view?.stopLoadingInTable()
            DispatchQueue.main.async {
                self?.coordinator?.presentPreviousStep()
            }
        }).catch({ [weak self] (error) in
            self?.view?.stopLoadingInTable()
            self?.view?.showAlert(withTitle: error.localizedTitle, message: error.localizedDescription)
        })
    }
    
    func didTapBackButton() {
        coordinator?.presentPreviousStep()
    }
    
    func shouldDisplayAddButton() -> Bool { return false }
    
    func didSelectAt(indexPath: IndexPath) { }
    
    func didTapAddButton() { }
    
    func getTitle() -> String {
        return "Announced Products"
    }
    
    func shouldDisplayBackButton() -> Bool {
        return true
    }
    
}
