//
//  CreateProductViewModelTests.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 08/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import Quick
import Nimble

class CreateProductViewModelTests: QuickSpec {
    
    var subject = CreateProductViewModel()
    var appCoordinator = AppCoordinatorMock()
    var mockedCoordinator = AppCoordinatorMock()
    var coordinator = ProductsCoordinator(baseCoordinator: AppCoordinatorMock())
    var interactor = ProductsInteractor()
    var repository = MockedProductsRespository()
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
            self.interactor = .init(repository: self.repository)
            self.view = .init()
            self.subject.coordinator = self.coordinator
            self.subject.interactor = self.interactor
            self.subject.view = self.view
        }
        
        describe("CreateProductViewModel behaviour tests") {
            it("should validate all fields") {
                let invalidName = ""
                let invalidPrice = "0"
                let invalidProductImage: UIImage? = nil
                
                self.view.productName = invalidName
                self.view.productPrice = invalidPrice
                self.view.productImage = invalidProductImage
                
                let invalidNamelError = ProductFields.Name.validate(string: invalidName) ?? ""
                let invalidPriceError = ProductFields.Price.validate(string: invalidPrice) ?? ""
                let invalidProductPictureError = "You have to add a product picture"

                self.subject.didTapCreateProduct()
                
                expect(self.view.showAlertTitle).to(equal("Invalid fields"))
                expect(self.view.showAlertMessage).to(equal(invalidNamelError + ", " + invalidPriceError + ", " + invalidProductPictureError))
            }
            
            it("should create account successfully") {
                self.view.productImage = .init()
                self.subject.didTapCreateProduct()
                expect(self.view.startLoadingCalled).to(beTrue())
                expect(self.view.stopLoadingCalled).toEventually(beTrue())
            }
            
            it("should handle request errors") {
                let errorMessage = "Unauthorized"
                self.repository.responseError = .init(message: errorMessage)
                self.subject.didTapCreateProduct()
                expect(self.view.startLoadingCalled).to(beTrue())
                expect(self.view.stopLoadingCalled).toEventually(beTrue())
                expect(self.view.showAlertMessage).to(equal(errorMessage))
            }
        }
        
    }
    
    class MockedView: CreateProductPresentable {
        
        var startLoadingCalled = false
        var stopLoadingCalled = false
        var showAlertTitle: String?
        var showAlertMessage: String?
        var productName = "Testing"
        var productDescription = "This is a test"
        var productPrice = "25"
        var productImage: UIImage? = .init()
        
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
        
        func getProductImage() -> UIImage? {
            return productImage
        }
        
        func getField(_ field: ProductFields) -> String {
            switch field {
            case .Name:
                return productName
            case .Description:
                return productDescription
            case .Price:
                return productPrice
            }
        }
        
        
    }
    
}
