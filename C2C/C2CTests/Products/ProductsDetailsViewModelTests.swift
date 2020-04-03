//
//  ProductsDetailsViewModelTests.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 02/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import Quick
import Nimble

class ProductsDetailsViewModelTests: QuickSpec {
    
    var subject = ProductDetailViewModel()
    var mockedView = MockedView()
    var mockedCoordinator = BasicCoordinatorMock()
    var mockedRepository = MockedProductsRespository()
    var mockedInteractor = ProductsInteractor(repository: MockedProductsRespository())
    
    override func spec() {
        
        beforeEach {
            self.subject = ProductDetailViewModel()
            self.mockedView = MockedView()
            self.mockedCoordinator = BasicCoordinatorMock()
            self.mockedRepository = MockedProductsRespository()
            self.mockedInteractor = ProductsInteractor(repository: self.mockedRepository)
            self.subject.view = self.mockedView
            self.subject.coordinator = self.mockedCoordinator
            self.subject.interactor = self.mockedInteractor
            self.subject.productID = 1
        }
        
        describe("ProductsDetailsViewModel behaviour tests") {
            
            it("should fetch object successfully") {
                self.subject.fetchObject()
                expect(self.mockedView.startLoadingCalled).to(beTrue())
                expect(self.mockedView.stopLoadingCalled).toEventually(beTrue())
                expect(self.mockedView.setProductNameCalled).toEventually(beTrue())
                expect(self.mockedView.setProductDescriptionCalled).toEventually(beTrue())
                expect(self.mockedView.setProductPriceCalled).toEventually(beTrue())
                expect(self.mockedView.setProductImageViewCalled).toEventually(beTrue())
            }
            
            it("should handle request erros") {
                let errorMessage = "some error"
                self.mockedRepository.responseError = .init(message: errorMessage)
                self.subject.fetchObject()
                expect(self.mockedView.startLoadingCalled).to(beTrue())
                expect(self.mockedView.stopLoadingCalled).toEventually(beTrue())
                expect(self.mockedView.showAlertCalled).toEventually(beTrue())
            }
            
            it("should call coordinator to go back") {
                self.subject.didTapExitButton()
                expect(self.mockedCoordinator.didCallPresentPreviousStep).to(beTrue())
            }
            
        }
        
    }
    
    class MockedView: ProductDetailViewControllerPresentable {
        
        var startLoadingCalled = false
        var stopLoadingCalled = false
        var showAlertCalled = false
        var setProductNameCalled = false
        var setProductDescriptionCalled = false
        var setProductPriceCalled = false
        var setProductImageViewCalled = false
        
        func startLoading() {
            startLoadingCalled = true
        }
        
        func stopLoading() {
            stopLoadingCalled = true
        }
        
        func showAlert(withTitle title: String, message: String) {
            showAlertCalled = true
        }
        
        func setProduct(name: String) {
            setProductNameCalled = true
        }
        
        func setProduct(price: String) {
            setProductPriceCalled = true
        }
        
        func setProduct(description: String) {
            setProductDescriptionCalled = true
        }
        
        func setProductImage() -> UIImageView? {
            setProductImageViewCalled = true
            return .init()
        }
        
    }
    
}
