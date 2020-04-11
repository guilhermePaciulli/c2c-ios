//
//  CreateAccountViewModelTests.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 05/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import Quick
import Nimble

class CreateAccountViewModelTests: QuickSpec {
    
    var subject = CreateAccountViewModel()
    var coordinator = AuthenticationCoordinationMock()
    var interactor = UserInteractor()
    var repository = UserRepositoryMock()
    var keychainManager = KeychainRepositoryMock()
    var view = MockedView()
    
    override func spec() {
        
        beforeEach {
            self.subject = .init()
            self.coordinator = .init()
            self.repository = .init()
            self.keychainManager = .init()
            self.interactor = .init(user: self.repository, keychain: self.keychainManager)
            self.view = .init()
            self.subject.coordinator = self.coordinator
            self.subject.interactor = self.interactor
            self.subject.view = self.view
        }
        
        describe("CreateAccountViewModel behaviour tests") {
            
            it("should present previous step when asked") {
                self.subject.didTapBackButton()
                expect(self.coordinator.presentPreviousStepCalled).to(beTrue())
            }
            
            it("should validate all fields") {
                let invalidEmail = "@doinga.com"
                let invalidCPF = "41548807803"
                let invalidProfilePicture: UIImage? = nil
                
                self.view.email = invalidEmail
                self.view.cpf = invalidCPF
                self.view.profilePicture = invalidProfilePicture
                
                let invalidEmailError = AccountFields.Email.validate(string: invalidEmail) ?? ""
                let invalidCPFError = AccountFields.CPF.validate(string: invalidCPF) ?? ""
                let invalidProfilePictureError = "You have to add a profile picture"

                self.subject.didTapToCreateAccount()
                
                expect(self.view.showAlertTitle).to(equal("Invalid fields"))
                expect(self.view.showAlertMessage).to(equal(invalidEmailError + ", " + invalidCPFError + ", " + invalidProfilePictureError))
            }
            
            it("should create account successfully") {
                self.view.profilePicture = .init()
                self.subject.didTapToCreateAccount()
                expect(self.view.startLoadingCalled).to(beTrue())
                expect(self.coordinator.didLoginCalled).toEventually(beTrue())
                expect(self.view.stopLoadingCalled).toEventually(beTrue())
            }
            
            it("should handle request errors") {
                self.view.profilePicture = .init()
                let errorMessage = "Unauthorized"
                self.repository.responseError = .init(message: errorMessage)
                self.subject.didTapToCreateAccount()
                expect(self.view.startLoadingCalled).to(beTrue())
                expect(self.coordinator.didLoginCalled).toEventually(beFalse())
                expect(self.view.stopLoadingCalled).toEventually(beTrue())
                expect(self.view.showAlertMessage).to(equal(errorMessage))
            }
            
        }
        
    }
    
    class MockedView: CreateAccountViewControllerPresentable {
        var startLoadingCalled = false
        var stopLoadingCalled = false
        var showAlertTitle: String?
        var showAlertMessage: String?
        var email = "rogerinho@doinga.com"
        var password = "12345678"
        var firstName = "Rogerinho"
        var surname = "do Ingá"
        var cpf = "41548807800"
        var profilePicture: UIImage?
        
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
        
        func get(field: AccountFields) -> String {
            switch field {
            case .Email:
                return email
            case .Password:
                return password
            case .CPF:
                return cpf
            case .FirstName:
                return firstName
            case .Surname:
                return surname
            }
        }
        
        func getProfilePicture() -> UIImage? {
            return profilePicture
        }
        
    }
    
    
}
