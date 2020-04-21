//
//  PurchaseInteractorTests.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 21/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import Quick
import Nimble

class PurchaseInteractorTests: QuickSpec {
    
    var repository = PurchaseRepositoryMock()
    var subject = PurchaseInteractor()
    var productAttr: ProductAttributes = .init(id: 0, name: "", attributesDescription: "", price: 0, productImageURL: "")
    
    override func spec() {
        
        beforeEach {
            self.repository = .init()
            self.subject = .init(repository: self.repository)
        }
        
        describe("Purchase request tests") {
            it("Should not fail") {
                waitUntil { (done) in
                    self.subject
                        .purchase(product: self.productAttr)
                        .done({ _ in
                            done()
                        })
                        .catch({ error in
                            XCTFail("The request should not have failed, error: \(error)")
                            done()
                        })
                }
            }
            it("Can fail sometimes") {
                let msg = "some odd error"
                self.repository.responseError = .init(message: msg)
                waitUntil { (done) in
                    self.subject
                        .purchase(product: self.productAttr)
                        .done({ _ in
                            XCTFail("The request should have failed")
                            done()
                        })
                        .catch({ error in
                            expect(error.localizedDescription).to(equal(msg))
                            done()
                        })
                }
            }
        }
        
    }
    
}
