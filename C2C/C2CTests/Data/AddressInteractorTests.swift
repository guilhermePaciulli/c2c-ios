//
//  AddressInteractorTests.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 11/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import Quick
import Nimble

class AddressInteractorTests: QuickSpec {
    
    var repository: AddressRepositoryMock = .init()
    var subject: AddressInteractor = .init(repository: AddressRepositoryMock())
    let mockedAddress: SaveAddress = .init(zipCode: "3452-3232", complement: "apt 78", number: "345")
    
    override func spec() {
        
        beforeEach {
            self.repository = .init()
            self.subject = .init(repository: self.repository)
        }
        
        describe("AddressInteractor GET request") {
            it("should return an address when successful") {
                waitUntil { (done) in
                    self.subject.get().done {
                        expect($0).toNot(beNil())
                        done()
                    }.catch { XCTFail($0.localizedDescription); done() }
                }
            }
            
            it("should return handle request error") {
                let message = "there was an error"
                self.repository.responseError = .init(message: message)
                
                waitUntil { (done) in
                    self.subject.get().done({ _ in XCTFail("the request should have failed"); done() })
                        .catch({
                            expect($0.localizedDescription).to(equal(message)); done()
                        })
                }
            }
        }
        
        describe("AddressInteractor POST request") {
            it("should create an address when successful") {
                waitUntil { (done) in
                    self.subject.create(self.mockedAddress).done {
                        expect($0).toNot(beNil())
                        done()
                    }.catch { XCTFail($0.localizedDescription); done() }
                }
            }
            it("should return handle request error") {
                let message = "there was an error"
                self.repository.responseError = .init(message: message)
                
                waitUntil { (done) in
                    self.subject.create(self.mockedAddress).done({ _ in XCTFail("the request should have failed"); done() })
                        .catch({
                            expect($0.localizedDescription).to(equal(message)); done()
                        })
                }
            }
        }
        
        describe("AddressInteractor PUT request") {
            it("should create an address when successful") {
                waitUntil { (done) in
                    self.subject.update(self.mockedAddress).done {
                        expect($0).toNot(beNil())
                        done()
                    }.catch { XCTFail($0.localizedDescription); done() }
                }
            }
            it("should return handle request error") {
                let message = "there was an error"
                self.repository.responseError = .init(message: message)
                
                waitUntil { (done) in
                    self.subject.update(self.mockedAddress).done({ _ in XCTFail("the request should have failed"); done() })
                        .catch({
                            expect($0.localizedDescription).to(equal(message)); done()
                        })
                }
            }
        }
        
    }
    
}
