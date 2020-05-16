//
//  AddressViewModelTests.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 11/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import Quick
import Nimble

class AddressViewModelTests: QuickSpec {
    
    var subject = AddressViewModel()
    var interactor = AddressInteractor()
    var repository = AddressRepositoryMock()
    var coordinator = BasicCoordinatorMock()
    var view = PresentableMock()
    
    override func spec() {
        
        
        beforeEach {
            self.subject = .init()
            self.repository = .init()
            self.interactor = .init(repository: self.repository)
            self.coordinator = .init()
            self.view = .init()
            self.subject.view = self.view
            self.subject.coordinator = self.coordinator
            self.subject.interactor = self.interactor
        }
        
        describe("AddressViewModel fetch when view appears") {
            
            it("should show view behaviour as success") {
                self.subject.fetchAddress()
                expect(self.view.startLoadingCalled).to(beTrue())
                expect(self.view.stopLoadingCalled).toEventually(beTrue())
                expect(self.subject.didFetchSuccessfully).toEventually(beTrue())
                expect(self.view.zipCode).toNot(beNil())
                expect(self.view.complement).toNot(beNil())
                // TODO:- Add this line when number exists in database
                /// expect(self.view.number).toNot(beNil())
            }
            
            it("should handle request errors") {
                let error = APIResponseError.init(message: "some error")
                self.repository.responseError = error
                self.subject.fetchAddress()
                expect(self.view.startLoadingCalled).to(beTrue())
                expect(self.view.stopLoadingCalled).toEventually(beTrue())
                expect(self.view.zipCode).toNot(beNil())
                expect(self.view.complement).toNot(beNil())
                expect(self.view.number).toNot(beNil())
                expect(self.subject.didFetchSuccessfully).toEventually(beFalse())
            }
            
        }
        
        describe("Address view model flow") {
            it("should pop view controller when user taps back button") {
                self.subject.didTapToCancel()
                expect(self.coordinator.didCallPresentPreviousStep).to(beTrue())
            }
        }
        
        describe("Address view model save address") {
            
            it("should validate all fields") {
                let invalidZipCode = ""
                let invalidComplement = ""
                let invalidNumber = "testing"
                
                self.view.zipCode = invalidZipCode
                self.view.complement = invalidComplement
                self.view.number = invalidNumber
                
                let invalidZipError = AddressFields.ZipCode.validate(string: invalidZipCode) ?? ""
                let invalidComplementError = AddressFields.Complement.validate(string: invalidComplement) ?? ""
                let invalidNumberError = AddressFields.Number.validate(string: invalidNumber) ?? ""
                
                self.subject.didTapToRegisterAddress()
                
                expect(self.view.showAlertTitle).to(equal("Invalid fields"))
                expect(self.view.showAlertMessage).to(equal(invalidZipError + ", " + invalidComplementError + ", " + invalidNumberError))
            }
            
            it("should present next step after saving address") {
                self.view.zipCode = "123432"
                self.view.complement = "apt 34"
                self.view.number = "234"
                self.subject.didTapToRegisterAddress()
                expect(self.view.startLoadingCalled).to(beTrue())
                expect(self.view.stopLoadingCalled).toEventually(beTrue())
                expect(self.coordinator.didCallPresentPreviousStep).toEventually(beTrue())
            }
            
            it("should handle request errors") {
                let msg = "some error"
                let error = APIResponseError.init(message: msg)
                self.repository.responseError = error
                self.view.zipCode = "123432"
                self.view.complement = "apt 34"
                self.view.number = "234"
                self.subject.didTapToRegisterAddress()
                expect(self.view.startLoadingCalled).to(beTrue())
                expect(self.view.stopLoadingCalled).toEventually(beTrue())
                expect(self.view.showAlertTitle).toEventuallyNot(beNil())
                expect(self.view.showAlertMessage).toEventually(equal(msg))
            }
            
        }
        
    }
    
    class PresentableMock: AddressPresentable {
        
        var startLoadingCalled = false
        var stopLoadingCalled = false
        var showAlertTitle: String?
        var showAlertMessage: String?
        var zipCode: String?
        var complement: String?
        var number: String?
        
        func setField(_ field: AddressFields, withValue value: String?) {
            switch field {
            case .ZipCode:
                zipCode = value
            case .Complement:
                complement = value
            case .Number:
                number = value
            }
        }
        
        func getField(_ field: AddressFields) -> String {
            switch field {
            case .ZipCode:
                return zipCode ?? ""
            case .Complement:
                return complement ?? ""
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
