//
//  PurchaseListViewModelTests.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 25/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import Quick
import Nimble

class PurchaseListViewModelTests: QuickSpec {
    
    var coordinator = BasicCoordinatorMock()
    var repository = PurchaseRepositoryMock()
    var interactor = PurchaseInteractor(repository: PurchaseRepositoryMock())
    var subject = PurchaseListViewModel(type: .purchases, interactor: PurchaseInteractor())
    var view = MockedView()
    var viewController: PurchaseListViewController = .instantiate()
    
    override func spec() {
        
        beforeEach {
            self.coordinator = .init()
            self.repository = .init()
            self.interactor = .init(repository: self.repository)
            self.subject = .init(type: .purchases, interactor: self.interactor)
            self.view = .init()
            self.subject.view = self.view
            self.subject.coordinator = self.coordinator
        }
        
        describe("when view will appear") {
            it("should reload table after successful fetch") {
                self.subject.fetchPurchases()
                expect(self.subject.isLoading).to(beTrue())
                expect(self.view.startRefreshingCalled).to(beTrue())
                expect(self.subject.purchaseList).toEventuallyNot(beEmpty())
                expect(self.view.reloadDataCalled).toEventually(beTrue())
                expect(self.view.stopLoadingInTableCalled).toEventually(beTrue())
                expect(self.subject.isLoading).toEventually(beFalse())
            }
            
            it("should show alert if there was an error in the request") {
                let msg = "some strange error"
                self.repository.responseError = .init(message: msg)
                self.subject.fetchPurchases()
                expect(self.subject.isLoading).to(beTrue())
                expect(self.view.startRefreshingCalled).to(beTrue())
                expect(self.view.stopLoadingInTableCalled).toEventually(beTrue())
                expect(self.view.alertDescription).toEventually(equal(msg))
                expect(self.subject.isLoading).toEventually(beFalse())
            }
        }
        
        describe("when table view will reload") {
            beforeEach {
                self.subject.fetchPurchases()
                expect(self.view.reloadDataCalled).toEventually(beTrue())
            }
            it("should give the right number of sections") {
                expect(self.subject.numberOfSections()).toEventually(equal(1))
            }
            it("should give the right number of rows in section") {
                expect(self.subject.numberOfRowsInSection(section: 0)).toEventually(equal(self.subject.purchaseList.count))
            }
        }
        describe("when user taps back button") {
            it("should present previous step") {
                self.subject.didTapBackButton()
                expect(self.coordinator.didCallPresentPreviousStep).to(beTrue())
            }
        }
        describe("when user taps a cell") {
            beforeEach {
                self.subject.fetchPurchases()
                expect(self.view.reloadDataCalled).toEventually(beTrue())
            }
            it("should present next step") {
                self.subject.tableView(didSelectRowAt: .init(row: 0, section: 0))
                expect(self.subject.selectedPurchase).toNot(beNil())
                expect(self.coordinator.didCallPresentNextStep).to(beTrue())
            }
        }
    }
    
    class MockedView: PurchaseListPresentable {
        
        var startRefreshingCalled = false
        var stopLoadingInTableCalled = false
        var alertMessage: String?
        var alertDescription: String?
        var reloadDataCalled = false
        
        func startRefreshing() {
            startRefreshingCalled = true
        }
        
        func stopLoadingInTable() {
            stopLoadingInTableCalled = true
        }
        
        func showAlert(withTitle title: String, message: String) {
            alertMessage = title
            alertDescription = message
        }
        
        func reloadData() {
            reloadDataCalled = true
        }
        
    }
    
}
