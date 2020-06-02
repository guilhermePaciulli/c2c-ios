//
//  PurchaseListViewModel.swift
//  C2C
//
//  Created by Guilherme Paciulli on 23/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit
import Kingfisher

protocol PurchaseListViewModelProtocol {
    var title: String { get }
    func fetchPurchases()
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func tableView(didSelectRowAt indexPath: IndexPath)
    func didTapBackButton()
    func clearData()
}


class PurchaseListViewModel: PurchaseListViewModelProtocol {
    
    // MARK:- Properties
    var coordinator: BasicCoordinationProtocol?
    var interactor: PurchaseInteractorProtocol
    var view: PurchaseListPresentable?
    var purchaseList: [Purchase] = []
    var selectedPurchase: Purchase?
    var title: String {
        switch type {
        case .purchases:
            return "Purchases"
        case .sells:
            return "Sells"
        }
    }
    var isLoading = false
    var type: PurchaseListingType

    // MARK:- Initialization
    init(interactor: PurchaseInteractorProtocol) {
        self.interactor = interactor
        self.type = .purchases
    }
    
    // MARK:- Protocol methods
    func fetchPurchases() {
        guard !isLoading else { return }
        isLoading = true
        if purchaseList.isEmpty { view?.startRefreshing() }
        interactor.getPurchases(ofType: type).done(on: .main) { [weak self] (result) in
            self?.purchaseList = result
            self?.view?.reloadData()
            self?.view?.stopLoadingInTable()
            self?.isLoading = false
        }.catch { [weak self] (error) in
            self?.view?.stopLoadingInTable()
            self?.view?.showAlert(withTitle: error.localizedTitle, message: error.localizedDescription)
            self?.isLoading = false
        }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return purchaseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PurchaseCell = tableView.dequeueReusableCell(for: indexPath)
        let purchase = purchaseList[indexPath.row]
        let img = cell.configureCell(withProductName: purchase.attributes.product.data.attributes.name,
                                     andStatus: getString(purchase.attributes.purchaseStatus))
        guard let url = URL(string: purchase.attributes.product.data.attributes.productImageURL) else { fatalError() }
        img?.kf.setImage(with: url)
        return cell
    }
    
    func tableView(didSelectRowAt indexPath: IndexPath) {
        selectedPurchase = purchaseList[indexPath.row]
        coordinator?.presentNextStep()
    }
    
    func didTapBackButton() {
        coordinator?.presentPreviousStep()
    }
    
    func clearData() {
        isLoading = false
        purchaseList = []
        view?.reloadData()
        view?.stopLoadingInTable()
    }
    
    private func getString(_ status: PurchaseStatus) -> String {
        switch status {
        case .waiting:
            return "Waiting"
        case .confirmed:
            return "Confirmed"
        case .inTransit:
            return "In transit"
        case .received:
            return "Received"
        }
    }
    
}
