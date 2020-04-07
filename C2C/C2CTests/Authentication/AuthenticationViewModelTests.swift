//
//  LoginViewModelTests.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 02/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import Quick
import Nimble

class AuthenticationViewModelTests: QuickSpec {
    
    var subject = AuthenticationViewModel()
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
        
        describe("AuthenticationViewModel behaviour tests") {
            
            it("should present next step when taps create account") {
                self.subject.didTapCreateAccountButton()
                expect(self.coordinator.presentNextStepCalled).toEventually(beTrue())
            }
            
            it("should validate email and password when logs in") {
                let invalidEmail = "t.com"
                let invalidPassword = "1234"
                
                var accountFields: AccountFields = .Email
                let emailError = accountFields.validate(string: invalidEmail) ?? ""
                accountFields = .Password
                let passwordError = accountFields.validate(string: invalidPassword) ?? ""
                
                
                self.view.email = invalidEmail
                self.view.password = invalidPassword
                self.subject.didTapLoginButton()
                expect(self.view.showAlertMessage).to(equal(emailError+", "+passwordError))
            }
            
            it("should login successfully") {
                self.subject.didTapLoginButton()
                expect(self.view.startLoadingCalled).to(beTrue())
                expect(self.coordinator.didLoginCalled).toEventually(beTrue())
                expect(self.view.stopLoadingCalled).toEventually(beTrue())
            }
            
            it("should handle request errors") {
                let errorMessage = "Unauthorized"
                self.repository.responseError = .init(message: errorMessage)
                self.subject.didTapLoginButton()
                expect(self.view.startLoadingCalled).to(beTrue())
                expect(self.coordinator.didLoginCalled).toEventually(beFalse())
                expect(self.view.stopLoadingCalled).toEventually(beTrue())
                expect(self.view.showAlertMessage).to(equal(errorMessage))
            }
            
        }
        
    }
    
    class MockedView: AuthenticationViewControllerPresentable {
        
        var startLoadingCalled = false
        var stopLoadingCalled = false
        var showAlertTitle: String?
        var showAlertMessage: String?
        var email = "rogerinho@doinga.com"
        var password = "12345678"
        
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
            default:
                return ""
            }
        }
        
    }
    
}
