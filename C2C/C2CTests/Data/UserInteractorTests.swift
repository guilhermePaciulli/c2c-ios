//
//  UserInteractor.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 02/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import Quick
import Nimble

class UserInteractorTests: QuickSpec {
    
    var subject = UserInteractor()
    var mockedRepository = UserRepositoryMock()
    var mockedKeychain = KeychainRepositoryMock()
    
    override func spec() {
        
        beforeEach {
            self.mockedRepository = UserRepositoryMock()
            self.mockedKeychain = KeychainRepositoryMock()
            self.subject = UserInteractor(user: self.mockedRepository, keychain: self.mockedKeychain)
        }
        
        describe("User interactor login request") {
            
            it("should return the jwt token successfully") {
                waitUntil { (done) in
                    self.subject.login(withEmail: "", andPassword: "").done {
                        expect(self.mockedKeychain.load(key: "jwt")).toNot(beNil())
                        done()
                    }.catch { XCTFail($0.localizedDescription); done() }
                }
            }
            
            it("should return handle request error") {
                let message = "there was an error"
                self.mockedRepository.responseError = .init(message: message)
                
                waitUntil { (done) in
                    self.subject.login(withEmail: "", andPassword: "")
                        .done({ _ in XCTFail("the request should have failed"); done() })
                        .catch({ expect($0.localizedDescription).to(equal(message)); done() })
                }
                
            }
        }
        
        describe("User interactor create account request") {

            it("should create an account successfully") {
                waitUntil { (done) in
                    self.subject.createAccount(.init(email: "", password: "", name: "", surname: "", cpf: "", profilePicture: .init()))
                        .done({
                            expect(self.mockedKeychain.load(key: "jwt")).toNot(beNil())
                            done()
                        })
                        .catch({ XCTFail($0.localizedDescription); done() })
                }
            }
            
            it("should return handle request error") {
                let message = "there was an error"
                self.mockedRepository.responseError = .init(message: message)
                
                waitUntil { (done) in
                    self.subject.createAccount(.init(email: "", password: "", name: "", surname: "", cpf: "", profilePicture: .init()))
                        .done({ _ in XCTFail("the request should have failed"); done() })
                        .catch({ expect($0.localizedDescription).to(equal(message)); done() })
                }
                
            }
        }
        
    }
    
}
