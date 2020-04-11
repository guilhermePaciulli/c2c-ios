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
    func fetchAddress()
}

class AddressViewModel: AddressViewModelProtocol {
    
    // MARK:- Properties
    var interactor: AddressInteractorProtocol
    var coordinator: BasicCoordinationProtocol?
    var view: AddressPresentable?
    var didFetchSuccessfully = false
    
    // MARK:- Initialization
    init(interactor: AddressInteractorProtocol = AddressInteractor()) {
        self.interactor = interactor
    }
    
    // MARK:- Delegate methods
    func fetchAddress() {
        view?.startLoading()
        interactor.get().done { [weak self] (attr) in
            self?.didFetchSuccessfully = true
            self?.view?.setField(.ZipCode, withValue: attr.zipCode)
            self?.view?.setField(.Number, withValue: attr.number)
            self?.view?.setField(.Complement, withValue: attr.complement)
            self?.view?.stopLoading()
        }.catch { [weak self] (error) in
            self?.didFetchSuccessfully = false
            self?.view?.stopLoading()
            self?.view?.showAlert(withTitle: error.localizedTitle, message: error.localizedDescription)
        }
    }
    
    func didTapToRegisterAddress() {
        guard let view = self.view else { return }
        let errors = AddressFields.allCases.compactMap({ return $0.validate(string: view.getField($0)) })
        if errors.isEmpty, let addr = getAddress() {
            (didFetchSuccessfully ? interactor.update(addr) : interactor.create(addr)).done(on: .main) { [weak self] _ in
                self?.view?.stopLoading()
                self?.coordinator?.presentPreviousStep()
            }.catch { [weak self] (error) in
                self?.view?.stopLoading()
                self?.view?.showAlert(withTitle: error.localizedTitle, message: error.localizedDescription)
            }
        } else {
            view.showAlert(withTitle: "Invalid fields", message: errors.joined(separator: ", "))
        }
    }
    
    func didTapToCancel() {
        coordinator?.presentPreviousStep()
    }
    
    // MARK:- Private methods
    private func getAddress() -> SaveAddress? {
        guard let view = self.view else { return nil }
        return .init(zipCode: view.getField(.ZipCode), complement: view.getField(.Complement), number: view.getField(.Number))
    }
    
}
