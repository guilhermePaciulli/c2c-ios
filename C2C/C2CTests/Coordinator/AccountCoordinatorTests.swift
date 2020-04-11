//
//  AccountCoordinatorTests.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 11/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import Quick
import Nimble

class AccountCoordinatorTests: QuickSpec {
    
    var appCoordinator: AppCoordinatorMock = .init()
    var subject: AccountCoordinator = .init(baseCoordinator: AppCoordinatorMock())
    
    override func spec() {
        
        beforeEach {
            self.appCoordinator = .init()
            self.subject = .init(baseCoordinator: self.appCoordinator)
        }
        
        describe("Account flow coordination tests") {
            
            it("should start at account flow") {
                expect(self.subject.state).to(equal(.Account))
            }
            
            it("should present address flow when requested") {
                self.subject.injector.accountViewModel.selectedFlow = .Address
                self.subject.presentNextStep()
                expect(self.subject.state).to(equal(.Address))
            }
            
            it("should return to account after address flow is completed") {
                self.subject.injector.accountViewModel.selectedFlow = .Address
                self.subject.presentNextStep()
                expect(self.subject.state).to(equal(.Address))
                self.subject.presentNextStep()
                expect(self.subject.state).to(equal(.Account))
            }
            
            it("should return to account at address when requested") {
                self.subject.injector.accountViewModel.selectedFlow = .Address
                self.subject.presentNextStep()
                expect(self.subject.state).to(equal(.Address))
                self.subject.presentNextStep()
                expect(self.subject.state).to(equal(.Account))
            }
            
            
        }
        
    }
    
}
