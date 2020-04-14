//
//  CreditCardViewModel.swift
//  C2C
//
//  Created by Guilherme Paciulli on 11/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import Foundation

protocol CreditCardViewModelProtocol {
    func didTapToCancel()
    func didTapToRegisterCreditCard()
    func fetchCreditCard()
}

class CreditCardViewModel: CreditCardViewModelProtocol {
    
    // MARK:- Properties
    var interactor: CreditCardInteractorProtocol
    var coordinator: BasicCoordinationProtocol?
    var view: CreditCardPresentable?
    var didFetchSuccessfully = false
    
    // MARK:- Initialization
    init(interactor: CreditCardInteractorProtocol = CreditCardInteractor()) {
        self.interactor = interactor
    }
    
    // MARK:- Delegate methods
    func fetchCreditCard() {
        view?.startLoading()
        interactor.get().done { [weak self] (attr) in
            self?.didFetchSuccessfully = true
            // TODO:- Set fields
            self?.view?.stopLoading()
        }.catch { [weak self] (error) in
            self?.didFetchSuccessfully = false
            self?.view?.stopLoading()
            // TODO:- Set fields
        }
    }
    
    func didTapToRegisterCreditCard() {
        guard let view = self.view else { return }
        // TODO:- Validate fields
//        let errors = CreditCardFields.allCases.compactMap({ return $0.validate(string: view.getField($0)) })
//        if errors.isEmpty, let addr = getCreditCard() {
//            view.startLoading()
//            (didFetchSuccessfully ? interactor.update(addr) : interactor.create(addr)).done(on: .main) { [weak self] _ in
//                self?.view?.stopLoading()
//                self?.coordinator?.presentPreviousStep()
//            }.catch { [weak self] (error) in
//                self?.view?.stopLoading()
//                self?.view?.showAlert(withTitle: error.localizedTitle, message: error.localizedDescription)
//            }
//        } else {
//            view.showAlert(withTitle: "Invalid fields", message: errors.joined(separator: ", "))
//        }
    }
    
    func didTapToCancel() {
        coordinator?.presentPreviousStep()
    }
    
    // MARK:- Private methods
    private func getCreditCard() -> SaveCreditCard? {
        guard let view = self.view else { return nil }
        // TODO:- Build credit card
        return nil
    }
    
}
