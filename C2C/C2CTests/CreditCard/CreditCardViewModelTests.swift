//
//  CreditCardViewModelTests.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 13/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import Quick
import Nimble

class CreditCardViewModelTests: QuickSpec {
    
    var subject = CreditCardViewModel()
    var interactor = CreditCardInteractor()
    var repository = CreditCardRepositoryMock()
    var coordinator = BasicCoordinatorMock()
    var view = PresentableMock()
    
    override func spec() {
        
        
        beforeEach {
            self.setup()
        }
        
        describe("CreditCardViewModel should fetch for credit card") {
            
            it("should behave as success") {
                self.subject.fetchCreditCard()
                expect(self.view.startLoadingCalled).to(beTrue())
                expect(self.view.stopLoadingCalled).toEventually(beTrue())
                expect(self.view.expirationDate).toNot(beNil())
                expect(self.view.number).toNot(beNil())
                expect(self.view.cvv).toNot(beNil())
                expect(self.view.owner).toNot(beNil())
                expect(self.subject.didFetchSuccessfully).toEventually(beTrue())
            }
            
            it("should handle request errors") {
                let error = APIResponseError.init(message: "some error")
                self.repository.responseError = error
                self.subject.fetchCreditCard()
                expect(self.view.startLoadingCalled).to(beTrue())
                expect(self.view.stopLoadingCalled).toEventually(beTrue())
                expect(self.view.number).toNot(beNil())
                expect(self.view.cvv).toNot(beNil())
                expect(self.view.owner).toNot(beNil())
                expect(self.view.expirationDate).toNot(beNil())
                expect(self.subject.didFetchSuccessfully).toEventually(beFalse())
            }
            
        }
        
        describe("CreditCard view model flow") {
            it("should pop view controller when user taps back button") {
                self.subject.didTapToCancel()
                expect(self.coordinator.didCallPresentPreviousStep).to(beTrue())
            }
        }
        
        describe("CreditCard view model save address") {
            
            it("should validate all fields") {
                let invalidCVV = ""
                let invalidOwner = ""
                let invalidNumber = "testing"
                
                self.view.owner = invalidOwner
                self.view.cvv = invalidOwner
                self.view.number = invalidNumber
                
                let invalidCVVError = CreditCardFields.CVV.validate(string: invalidCVV) ?? ""
                let invalidOwnerError = CreditCardFields.Owner.validate(string: invalidOwner) ?? ""
                let invalidNumberError = CreditCardFields.Number.validate(string: invalidNumber) ?? ""
                
                self.subject.didTapToRegisterCreditCard()
                
                expect(self.view.showAlertTitle).to(equal("Invalid fields"))
                expect(self.view.showAlertMessage).to(equal(invalidNumberError + ", " + invalidOwnerError + ", " + invalidCVVError))
            }
            
            it("should present next step after saving address") {
                self.view.cvv = "858"
                self.view.number = "4197394215553472"
                self.view.owner = "August Jefferson"
                self.view.expirationDate = "01/24"
                self.subject.didTapToRegisterCreditCard()
                expect(self.view.startLoadingCalled).to(beTrue())
                expect(self.view.stopLoadingCalled).toEventually(beTrue())
                expect(self.coordinator.didCallPresentPreviousStep).toEventually(beTrue())
            }
            
            it("should handle request errors") {
                let msg = "some error"
                let error = APIResponseError.init(message: msg)
                self.repository.responseError = error
                self.view.cvv = "858"
                self.view.number = "4197394215553472"
                self.view.owner = "August Jefferson"
                self.view.expirationDate = "01/24"
                self.subject.didTapToRegisterCreditCard()
                expect(self.view.startLoadingCalled).to(beTrue())
                expect(self.view.stopLoadingCalled).toEventually(beTrue())
                expect(self.view.showAlertTitle).toEventuallyNot(beNil())
                expect(self.view.showAlertMessage).toEventually(equal(msg))
            }
            
        }
        
    }
    
    func setup() {
        self.subject = CreditCardViewModel()
        self.repository = CreditCardRepositoryMock()
        self.interactor = CreditCardInteractor(repository: self.repository)
        self.coordinator = BasicCoordinatorMock()
        self.view = PresentableMock()
        self.subject.view = self.view
        self.subject.coordinator = self.coordinator
        self.subject.interactor = self.interactor
    }
    
    class PresentableMock: CreditCardPresentable {
        
        var startLoadingCalled = false
        var stopLoadingCalled = false
        var showAlertTitle: String?
        var showAlertMessage: String?
        var number: String?
        var cvv: String?
        var owner: String?
        var expirationDate: String?
        
        func setExpirationDate(_ date: String) {
            expirationDate = date
        }
        
        func getExpirationDate() -> String {
            return expirationDate ?? ""
        }
        
        func setField(_ field: CreditCardFields, withValue value: String?) {
            switch field {
            case .Number:
                number = value
            case .CVV:
                cvv = value
            case .Owner:
                owner = value
            }
        }
        
        func getField(_ field: CreditCardFields) -> String {
            switch field {
            case .CVV:
                return cvv ?? ""
            case .Owner:
                return owner ?? ""
            case .Number:
                return number ?? ""
            }
        }
        
        func startLoading() {
            startLoadingCalled = true
        }
        
        func stopLoading() {
            stopLoadingCalled = true
        }
        
        func showAlert(withTitle title: String, message: String) {
            showAlertTitle = title
            showAlertMessage = message
        }
        
        
    }
    
}
