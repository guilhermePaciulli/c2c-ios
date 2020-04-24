//
//  PurchaseListViewModel.swift
//  C2C
//
//  Created by Guilherme Paciulli on 23/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

protocol PurchaseListViewModelProtocol {
    func fetchPurchases()
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func tableView(didSelectRowAt indexPath: IndexPath)
    func didTapBackButton()
}


class PurchaseListViewModel {
    
}
