//
//  AddressViewModel.swift
//  C2C
//
//  Created by Guilherme Paciulli on 11/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import Foundation

protocol AddressViewModelProtocol {
    func didTapToCancel()
    func didTapToRegisterAddress()
}

class AddressViewModel: AddressViewModelProtocol {
    
    // MARK:- Properties
    var interactor: UserInteractorProtocol
    var coordinator: BasicCoordinationProtocol?
    var view: AddressPresentable?
    
    // MARK:- Initialization
    init(interactor: UserInteractorProtocol = UserInteractor()) {
        self.interactor = interactor
    }
    
    // MARK:- Delegate methods
    func didTapToRegisterAddress() {
        guard let view = self.view else { return }
        let errors = AddressFields.allCases.compactMap({ return $0.validate(string: view.getField($0)) })
        if errors.isEmpty /*, let acc = getAccount()*/ {
        } else {
            view.showAlert(withTitle: "Invalid fields", message: errors.joined(separator: ", "))
        }
    }
    
    
    func didTapToCancel() {
        coordinator?.presentPreviousStep()
    }
    
    // MARK:- Private methods
    private func getAccount() {
    }
    
}
