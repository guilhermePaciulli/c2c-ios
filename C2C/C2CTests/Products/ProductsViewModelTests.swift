//
//  ProductsViewModelTests.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 02/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import Quick
import Nimble

class ProductsViewModelTests: QuickSpec {
    
    var subject = ProductsViewModel()
    var mockedRepository = MockedProductsRespository()
    var mockedCoordinator = AppCoordinatorMock()
    var coordinator = ProductsCoordinator(baseCoordinator: AppCoordinatorMock())
    var mockedInteractor = ProductsInteractor(repository: MockedProductsRespository())
    var mockedView = MockedView()
    
    override func spec() {
        
        beforeEach {
            self.subject = .init()
            self.mockedCoordinator = .init()
            self.coordinator = .init(baseCoordinator: self.mockedCoordinator)
            self.mockedRepository = .init()
            self.mockedInteractor = .init(repository: self.mockedRepository)
            self.mockedView = .init()
            self.subject.delegate = self.mockedView
            self.subject.coordinator = self.coordinator
            self.subject.interactor = self.mockedInteractor
        }
        
        
        describe("ProductsViewModel behaviour tests") {
            it("should fetch object successfully") {
                self.subject.getObject()
                expect(self.mockedView.reloadDataCalled).toEventually(beTrue())
                expect(self.mockedView.stopLoadingInTableCalled).toEventually(beTrue())
                expect(self.subject.numberOfRowsInSection(section: 0)).toEventually(beGreaterThan(0))
            }
            
            it("should handle request errors") {
                let errorMsg = "some error"
                self.mockedRepository.responseError = .init(message: errorMsg)
                self.subject.getObject()
                expect(self.mockedView.alertMessage).toEventually(equal(errorMsg))
                expect(self.mockedView.reloadDataCalled).toEventually(beTrue())
            }
            
            it("should present details about the product") {
                self.subject.getObject()
                expect(self.mockedView.reloadDataCalled).toEventually(beTrue())
                self.subject.didSelectAt(indexPath: .init(row: 0, section: 0))
                expect(self.subject.selectedProduct).toEventuallyNot(beNil())
                expect(self.mockedCoordinator.presentedViewController).toEventually(beAKindOf(ProductDetailViewController.self))
            }
            
            it("should display and dismiss add product view controller") {
                self.subject.didTapAddButton()
                expect(self.coordinator.state).toEventually(equal(.CreateProduct))
            }
            
        }
        
    }
    
    class MockedView: ProductsViewControllerPresentable {
        var alertTitle: String?
        var alertMessage: String?
        var stopLoadingInTableCalled = false
        var reloadDataCalled = false
        
        func stopLoadingInTable() {
            stopLoadingInTableCalled = true
        }
        
        func showAlert(withTitle title: String, andMessage message: String) {
            alertTitle  = title
            alertMessage = message
        }
        
        func reloadData() {
            reloadDataCalled = true
        }
        
    }
    
}

