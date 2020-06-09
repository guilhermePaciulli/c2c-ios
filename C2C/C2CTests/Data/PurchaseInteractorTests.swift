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
    var productAttr: ProductAttributes = .init(id: 0, name: "", attributesDescription: "", price: 0, productImageURL: "", activated: true)
    
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
            it("should return purchases from the user") {
                waitUntil { (done) in
                    self.subject.getPurchases(ofType: .purchases)
                        .done({ result in
                            expect(result).toNot(beEmpty())
                            done()
                        })
                        .catch({ error in
                            XCTFail("The request should not have failed, error: \(error)")
                            done()
                        })
                }
            }
            it("can fail all requests when fetching purchases from the user") {
                let msg = "some server or internet error is happening"
                self.repository.responseError = .init(message: msg)
                waitUntil { (done) in
                    self.subject
                        .getPurchases(ofType: .purchases)
                        .done({ result in
                            XCTFail("The fetching should have failed")
                            done()
                        })
                        .catch({ error in
                            expect(error.localizedDescription).to(equal(msg))
                            done()
                        })
                }
            }
            it("should be successfull when patching a purchase") {
                waitUntil { (done) in
                    self.subject.updatePurchase(purchase: purchaseToBePatched!)
                        .done({ _ in
                            done()
                        })
                        .catch({ error in
                            XCTFail("Why the request failed? Here's the error: \(error)")
                            done()
                        })
                }
            }
            it("should be successfull when deleting a purchase") {
                waitUntil { (done) in
                    self.subject.cancel(purchase: purchaseToBePatched!).done(on: .main) { (_) in
                        done()
                    }.catch { (error) in
                        XCTFail("\(error)")
                    }
                }
            }
            it("must fail sometimes") {
                self.repository.responseError = .init(message: "fatal error")
                waitUntil { (done) in
                    self.subject.cancel(purchase: purchaseToBePatched!).done({ result in
                            XCTFail("The fetching should have failed")
                            done()
                        }).catch({ error in
                            expect(error.localizedDescription).to(equal("fatal error"))
                            done()
                        })
                }
            }
            it("can fail, like human beings can fail") {
                let msg = "fatal error is happening"
                self.repository.responseError = .init(message: msg)
                waitUntil { (done) in
                    self.subject
                        .updatePurchase(purchase: purchaseToBePatched!)
                        .done({ result in
                            XCTFail("The fetching should have failed")
                            done()
                        })
                        .catch({ error in
                            expect(error.localizedDescription).to(equal(msg))
                            done()
                        })
                }
            }
            var purchaseToBePatched: Purchase? {
                guard let data = FilesHelper.loadFileAsData("Purchases"),
                    let patchedPurchase = try? JSONDecoder()
                        .decode(DataDecodable<[Purchase]>.self, from: data)
                        .data.first else { return nil }
                return patchedPurchase
            }
        }
    }
}
