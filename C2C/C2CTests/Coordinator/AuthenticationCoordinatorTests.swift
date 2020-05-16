//
//  AuthenticationCoordinatorTests.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 05/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import Quick
import Nimble

class AuthenticationCoordinatorTests: QuickSpec {
    
    var subject = AuthenticationCoordinator(baseCoordinator: AppCoordinatorMock())
    var mockedAppCoordinator = AppCoordinatorMock()
    
    override func spec() {
        
        beforeEach {
            self.mockedAppCoordinator = AppCoordinatorMock()
            self.subject = .init(baseCoordinator: self.mockedAppCoordinator)
        }
        
        describe("Product coordinator flow tests") {
            
            it("should start at login view") {
                expect(self.subject.state).to(equal(.Authentication))
            }
            
            it("should present create account view") {
                self.subject.presentNextStep()
                expect(self.subject.state).to(equal(.AccountCreation))
            }
            
            it("should dismiss create account view") {
                self.subject.presentNextStep()
                self.subject.presentPreviousStep()
                expect(self.subject.state).to(equal(.Authentication))
            }
            
            it("should call did login when user logs in") {
                self.subject.didLogin()
                expect(self.mockedAppCoordinator.didLoginCalled).to(beTrue())
            }
        }
        
    }
    
}
