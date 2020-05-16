//
//  AccountViewModelTests.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 06/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import Quick
import Nimble

class AccountViewModelTests: QuickSpec {
    
    var subject = AccountViewModel()
    var appCoordinator = AppCoordinatorMock()
    var coordinator = AccountCoordinator(baseCoordinator: AppCoordinatorMock())
    var interactor = UserInteractor()
    var repository = UserRepositoryMock()
    var keychainManager = KeychainRepositoryMock()
    var userDefaults = UserDefaultsRepositoryMock()
    var view = MockedView()
    
    
    override func spec() {
        
        beforeEach {
            self.subject = .init()
            self.appCoordinator = .init()
            self.coordinator = .init(baseCoordinator: self.appCoordinator)
            self.repository = .init()
            self.keychainManager = .init()
            self.keychainManager = .init()
            self.interactor = .init(user: self.repository, keychain: self.keychainManager, userDefaults: self.userDefaults)
            self.view = .init()
            self.subject.coordinator = self.coordinator
            self.subject.interactor = self.interactor
            self.subject.view = self.view
        }
        
        describe("AccountViewModel behaviour tests") {
            
            it("should fetch user when requested") {
                self.userDefaults.shouldReturnValue = false
                self.subject.fetchUser()
                expect(self.view.startLoadingCalled).to(beTrue())
                expect(self.view.stopLoadingCalled).toEventually(beTrue())
                expect(self.view.firstName).toEventuallyNot(beNil())
                expect(self.view.surname).toEventuallyNot(beNil())
                expect(self.view.email).toEventuallyNot(beNil())
                expect(self.view.cpf).toEventuallyNot(beNil())
                expect(self.view.profilePicture).toEventuallyNot(beNil())
            }
            
            it("should fetch user from user defaults when available") {
                self.userDefaults.shouldReturnValue = true
                self.subject.fetchUser()
                expect(self.view.firstName).toEventuallyNot(beNil())
                expect(self.view.surname).toEventuallyNot(beNil())
                expect(self.view.email).toEventuallyNot(beNil())
                expect(self.view.cpf).toEventuallyNot(beNil())
                expect(self.view.profilePicture).toEventuallyNot(beNil())
            }
            
            it("should handle request errors") {
                let errorMessage = "fatal error"
                self.repository.responseError = APIResponseError.init(message: errorMessage)
                self.userDefaults.shouldReturnValue = false 
                self.subject.fetchUser()
                expect(self.view.startLoadingCalled).to(beTrue())
                expect(self.view.stopLoadingCalled).toEventually(beTrue())
                expect(self.appCoordinator.didLogoutCalled).toEventually(beTrue())
            }
            
        }
        
    }
    
    class MockedView: AccountViewControllerPresentable {
        
        var startLoadingCalled = false
        var stopLoadingCalled = false
        var showAlertTitle: String?
        var showAlertMessage: String?
        var email: String?
        var firstName: String?
        var surname: String?
        var cpf: String?
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
        
        func setName(_ name: String) {
            self.firstName = name
        }
        
        func setSurname(_ surname: String) {
            self.surname = surname
        }
        
        func setEmail(_ email: String) {
            self.email = email
        }
        
        func setCPF(_ cpf: String) {
            self.cpf = cpf
        }
        
        func setProfilePicture() -> UIImageView? {
            self.profilePicture = .init()
            return .init()
        }
        
        
    }
    
}
