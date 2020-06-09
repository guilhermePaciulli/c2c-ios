//
//  PersonalProductsViewModelTests.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 09/06/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import UIKit
import Quick
import Nimble


class PersonalProductsViewModelTests: QuickSpec {
    
    var subject = PersonalProductsViewModel()
    var repository = MockedProductsRespository()
    var coordinator = BasicCoordinatorMock()
    var interactor = ProductsInteractor(repository: MockedProductsRespository())
    var mockedView = MockedProductsView()
    
    override func spec() {
        
        beforeEach {
            self.subject = .init()
            self.coordinator = .init()
            self.repository = .init()
            self.interactor = .init(repository: self.repository)
            self.mockedView = .init()
            self.subject.view = self.mockedView
            self.subject.coordinator = self.coordinator
            self.subject.productsInteractor = self.interactor
        }
        
        
        describe("ProductsViewModel behaviour tests") {
            it("should fetch object successfully") {
                self.subject.getObject()
                expect(self.mockedView.reloadDataCalled).toEventually(beTrue())
                expect(self.mockedView.startRefreshingCalled).toEventually(beTrue())
                expect(self.mockedView.stopLoadingInTableCalled).toEventually(beTrue())
                expect(self.subject.numberOfRowsInSection(section: 0)).toEventually(beGreaterThan(0))
            }
            
            it("should handle API errors") {
                let someErrorMSG = "fatal error in backend"
                self.repository.responseError = .init(message: someErrorMSG)
                self.subject.getObject()
                expect(self.mockedView.reloadDataCalled).toEventually(beTrue())
                expect(self.mockedView.alertMessage).toEventually(equal(someErrorMSG))
            }
            it("should always hide add button and show back button") {
                expect(self.subject.shouldDisplayAddButton()).to(beFalse())
                expect(self.subject.shouldDisplayBackButton()).to(beTrue())
            }
            it("should return the right title") {
                expect(self.subject.getTitle()).to(equal("Announced Products"))
            }
            it("should call activation and success") {
                self.subject.getObject()
                expect(self.mockedView.reloadDataCalled).toEventually(beTrue())
                self.subject.didSelectAt(indexPath: .init(row: 0, section: 0))
                expect(self.mockedView.reloadDataCalled).toEventually(beTrue())
            }
            it("should handle api erros when activating product") {
                let msg = "fatal error is happening"
                self.repository.responseError = .init(message: msg)
                self.subject.getObject()
                expect(self.mockedView.reloadDataCalled).toEventually(beTrue())
                expect(self.mockedView.alertMessage).toEventually(equal(msg))
                expect(self.mockedView.startRefreshingCalled).toEventually(beTrue())
            }
            it("should present previous step when requested") {
                self.subject.didTapBackButton()
                expect(self.coordinator.didCallPresentPreviousStep).to(beTrue())
            }
        }
    }
    
}
