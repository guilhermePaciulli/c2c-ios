//
//  CreditCardInteractorTests.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 11/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import Quick
import Nimble

class CreditCardInteractorTests: QuickSpec {
    
    var repository: CreditCardRepositoryMock = .init()
    var subject: CreditCardInteractor = .init(repository: CreditCardRepositoryMock())
    let mockedCreditCard: SaveCreditCard = .init(number: "4521009716146231", cvv: "385", owner: "Rogerinho do Ingá", expiration: "06/23")
    
    override func spec() {
        
        beforeEach {
            self.repository = .init()
            self.subject = .init(repository: self.repository)
        }
        
        describe("CreditCardInteractor GET request") {
            it("should return an credit card when successful") {
                waitUntil { (done) in
                    self.subject.get().done { res in
                        expect(res).toNot(beNil())
                        done()
                    }.catch { error in
                        XCTFail(error.localizedDescription)
                        done()
                    }
                }
            }
            
            it("should handle request error for this thing") {
                let message = "there was an error fetching credit card"
                self.repository.responseError = .init(message: message)
                
                waitUntil { (done) in
                    self.subject.get().done({ _ in
                        XCTFail("the request did not fail :(")
                        done()
                    }).catch({ err in
                        expect(err.localizedDescription).to(equal(message)); done()
                    })
                }
            }
        }
        
        describe("CreditCardInteractor POST request") {
            it("should create an address when successful") {
                waitUntil { (done) in
                    self.subject.create(self.mockedCreditCard).done {
                        expect($0).toNot(beNil())
                        done()
                    }.catch { XCTFail($0.localizedDescription); done() }
                }
            }
            it("should return handle request error") {
                let message = "there was an error"
                self.repository.responseError = .init(message: message)
                
                waitUntil { (done) in
                    self.subject.create(self.mockedCreditCard).done({ _ in XCTFail("the request should have failed"); done() })
                        .catch({
                            expect($0.localizedDescription).to(equal(message)); done()
                        })
                }
            }
        }
        
        describe("CreditCardInteractor PUT request") {
            it("should create an address when successful") {
                waitUntil { (done) in
                    self.subject.update(self.mockedCreditCard).done {
                        expect($0).toNot(beNil())
                        done()
                    }.catch { XCTFail($0.localizedDescription); done() }
                }
            }
            it("should return handle request error") {
                let message = "there was an error"
                self.repository.responseError = .init(message: message)
                
                waitUntil { (done) in
                    self.subject.update(self.mockedCreditCard).done({ _ in XCTFail("the request should have failed"); done() })
                        .catch({
                            expect($0.localizedDescription).to(equal(message)); done()
                        })
                }
            }
        }
        
    }
    
}
