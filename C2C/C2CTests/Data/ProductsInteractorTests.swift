//
//  ProductsInteractorTests.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 22/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import Nimble
import Quick

class ProductsInteractorTests: QuickSpec {
    
    var subject = ProductsInteractor()
    var mockedRepository = MockedProductsRespository()
    
    override func spec() {
        
        beforeEach {
            self.mockedRepository = MockedProductsRespository()
            self.subject = ProductsInteractor(repository: self.mockedRepository)
        }
        
        describe("Product interactor list request") {
            
            it("should return the product list successfully") {
                var products: [Product]?
                
                waitUntil { (done) in
                    self.subject.getAll().done { products = $0; done()
                    }.catch { XCTFail($0.localizedDescription); done() }
                }
                
                expect(products).toNot(beNil())
                expect(products).toNot(beEmpty())
            }
            
            it("should return handle request error") {
                let message = "there was an error"
                self.mockedRepository.responseError = .init(message: message)
                
                waitUntil { (done) in
                    self.subject.getAll()
                        .done({ _ in XCTFail("the request should have failed"); done() })
                        .catch({ expect($0.localizedDescription).to(equal(message)); done() })
                }
                
            }
        }
        
        describe("Product interactor get one request") {

            it("should return one product successfully") {
                var product: Product?

                waitUntil { (done) in
                    self.subject.getProduct(withId: 1)
                        .done({ product = $0; done() })
                        .catch({ XCTFail($0.localizedDescription); done() })
                }
                expect(product).toNot(beNil())
                expect(product?.attributes.id).to(equal(1))
            }
            
            it("should return handle request error") {
                let message = "there was an error"
                self.mockedRepository.responseError = .init(message: message)
                
                waitUntil { (done) in
                    self.subject.getProduct(withId: 99)
                        .done({ _ in XCTFail("the request should have failed"); done() })
                        .catch({ expect($0.localizedDescription).to(equal(message)); done() })
                }
                
            }
        }
        
    }
    
}
