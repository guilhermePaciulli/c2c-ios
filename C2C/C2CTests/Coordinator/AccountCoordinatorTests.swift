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
            
        }
        describe("Address flow") {
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
        
        describe("Credit Card flow") {
            it("should present credit card flow when requested") {
                self.subject.injector.accountViewModel.selectedFlow = .CreditCard
                self.subject.presentNextStep()
                expect(self.subject.state).to(equal(.CreditCard))
            }
            
            it("should return to credit card after credit card flow is completed") {
                self.subject.injector.accountViewModel.selectedFlow = .CreditCard
                self.subject.presentNextStep()
                expect(self.subject.state).to(equal(.CreditCard))
                self.subject.presentNextStep()
                expect(self.subject.state).to(equal(.Account))
            }
            
            it("should return to account at credit card when requested") {
                self.subject.injector.accountViewModel.selectedFlow = .CreditCard
                self.subject.presentNextStep()
                expect(self.subject.state).to(equal(.CreditCard))
                self.subject.presentNextStep()
                expect(self.subject.state).to(equal(.Account))
            }
        }
        
        describe("Purchases flow") {
            it("should present purchases when requested") {
                self.subject.injector.accountViewModel.selectedFlow = .Purchases(type: .purchases)
                self.subject.presentNextStep()
                expect(self.subject.state).to(equal(.Purchases(type: .purchases)))
            }
            it("should present sells when requested") {
                self.subject.injector.accountViewModel.selectedFlow = .Purchases(type: .sells)
                self.subject.presentNextStep()
                expect(self.subject.state).to(equal(.Purchases(type: .sells)))
            }
            it("should return to account at purchases when requested") {
                self.subject.injector.accountViewModel.selectedFlow = .Purchases(type: .purchases)
                self.subject.presentNextStep()
                expect(self.subject.state).to(equal(.Purchases(type: .purchases)))
                self.subject.presentPreviousStep()
                expect(self.subject.state).to(equal(.Account))
            }
            it("should present purchase details") {
                self.subject.injector.accountViewModel.selectedFlow = .Purchases(type: .sells)
                self.subject.presentNextStep()
                self.subject.injector.purchaseListViewModel.selectedPurchase = self.selectedPurchase
                self.subject.presentNextStep()
                expect(self.subject.state).to(equal(.PurchaseDetail))
                expect(self.subject.injector.purchaseDetailViewModel.purchase?.product.data.id)
                    .to(equal(self.selectedPurchase?.product.data.id))
                self.subject.presentPreviousStep()
                expect(self.subject.state).to(equal(.Purchases(type: .sells)))
            }
        }
    }
    
    var selectedPurchase: PurchaseAttributes? {
        guard let data = FilesHelper
            .loadFileAsData("Purchases"),
            let purchase = try?
                JSONDecoder().decode(DataDecodable<[Purchase]>.self,
                                     from: data)
                    .data.first else { return nil }
        return purchase
            .attributes
    }
}
