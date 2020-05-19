//
//  PurchaseDetailViewModelTests.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 18/05/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import Quick
import Nimble

class PurchaseDetailViewModelTests: QuickSpec {
    
    var subject = PurchaseDetailViewModel()
    var coordinator = BasicCoordinatorMock()
    var purchaseRepository = PurchaseRepositoryMock()
    var interactor = PurchaseInteractor()
    var view = MockedView()
    
    override func spec() {
        
        beforeEach {
            self.subject = .init()
            self.coordinator = .init()
            self.purchaseRepository = .init()
            self.interactor = .init(repository: self.purchaseRepository)
            self.subject.coordinator = self.coordinator
            self.subject.interactor = self.interactor
            self.subject.view = self.view
        }
        
        describe("Auxiliary methods behaviour") {
            it("should give right color and label for each purchase status") {
                var status: PurchaseStatus = .waiting
                expect(status.getTextAndColor().0).to(equal("Waiting"))
                expect(status.getTextAndColor().1).to(equal(.systemYellow))
                status = .confirmed
                expect(status.getTextAndColor().0).to(equal("Confirmed"))
                expect(status.getTextAndColor().1).to(equal(.systemOrange))
                status = .inTransit
                expect(status.getTextAndColor().0).to(equal("In transit"))
                expect(status.getTextAndColor().1).to(equal(.systemRed))
                status = .received
                expect(status.getTextAndColor().0).to(equal("Received"))
                expect(status.getTextAndColor().1).to(equal(.secondarySystemBackground))
            }
            
            it("should give the right next purchase status") {
                var status: PurchaseStatus = .waiting
                expect(status.getNextStatus()).to(equal("Confirm request"))
                status = .confirmed
                expect(status.getNextStatus()).to(equal("Confirm item dispatched"))
                status = .inTransit
                expect(status.getNextStatus()).to(equal("Confirm you received the item"))
                status = .received
                expect(status.getNextStatus()).to(equal(""))
            }
        }
        
        describe("View actions") {
            it("should present previous step when requested") {
                self.subject.didTapBackButton()
                expect(self.coordinator.didCallPresentPreviousStep).to(beTrue())
            }
        }
        
        describe("View setup") {
            
            it("should populate all the data") {
                self.subject.purchase = self.purchase
                self.subject.viewWillAppear()
                expect(self.view.zipCode).to(equal("02404060"))
                expect(self.view.productName).to(equal("Boeing 737"))
                expect(self.view.productDescription).to(equal("Esse boeing é muito mais top que muita gente por aí"))
                expect(self.view.paymentMethodEnding).to(equal("6231"))
                expect(self.view.statusTitle).to(equal("Waiting"))
                expect(self.view.statusColor).to(equal(.systemYellow))
                expect(self.view.statusButtonText).to(equal("Confirm request"))
            }
            
            it("should populate view data as a buyer") {
                self.subject.purchase = self.purchase
                self.subject.viewWillAppear()
                expect(self.view.statusButtonHidden).to(beTrue())
                expect(self.view.paymentMethodHidden).to(beFalse())
                expect(self.subject.getViewName()).to(equal("You bought"))
            }
            
            it("should populate view data as a seller") {
                self.subject.purchase = self.sell
                self.subject.viewWillAppear()
                expect(self.view.statusButtonHidden).to(beFalse())
                expect(self.view.paymentMethodHidden).to(beTrue())
                expect(self.subject.getViewName()).to(equal("You sold"))
            }
            
        }
        
    }
    
    var purchase: PurchaseAttributes? {
        guard let data = FilesHelper.loadFileAsData("Purchases"),
            let purchase = try? JSONDecoder().decode(DataDecodable<[Purchase]>.self, from: data).data.first else { return nil }
        return purchase.attributes
    }
    
    var sell: PurchaseAttributes? {
        guard let data = FilesHelper.loadFileAsData("Sells"),
            let sell = try? JSONDecoder().decode(DataDecodable<[Purchase]>.self, from: data).data.first else { return nil }
        return sell.attributes
    }
    
    class MockedView: PurchaseDetailPresentable {
        
        var paymentMethodEnding = ""
        func setPaymentMethodEnding(_ ending: String) {
            paymentMethodEnding = ending
        }
        
        var zipCode = ""
        func setZipCode(_ zipCode: String) {
            self.zipCode = zipCode
        }
        
        var productName = ""
        func setProductName(_ name: String) {
            productName = name
        }
        
        var productDescription = ""
        func setProductDescription(_ value: String) {
            productDescription = value
        }
        
        func setProductImage() -> UIImageView? {
            return .init()
        }
        
        var statusTitle = ""
        var statusColor: UIColor?
        func setPurchaseStatus(withTitle title: String, andColor color: UIColor) {
            statusTitle = title
            statusColor = color
        }
        
        var statusButtonHidden: Bool?
        func setStatusButtonHidden(_ hidden: Bool) {
            statusButtonHidden = hidden
        }
        
        var paymentMethodHidden: Bool?
        func setPaymentMethodHidden(_ hidden: Bool) {
            paymentMethodHidden = hidden
        }
        
        var statusButtonText = ""
        func setStatusButtonText(_ text: String) {
            statusButtonText = text
        }
    }
    
    
}
