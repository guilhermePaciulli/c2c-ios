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
    var mockedUserDefaultsRepository = UserDefaultsRepositoryMock()
    
    override func spec() {
        
        beforeEach {
            self.mockedRepository = .init()
            self.mockedKeychain = .init()
            self.mockedUserDefaultsRepository = .init()
            self.subject = UserInteractor(user: self.mockedRepository, keychain: self.mockedKeychain, userDefaults: self.mockedUserDefaultsRepository)
        }
        
        describe("User interactor login request") {
            
            it("should return the jwt token successfully") {
                waitUntil { (done) in
                    self.subject.login(withEmail: "", andPassword: "").done {
                        expect(self.mockedKeychain.load(key: "jwt")).toNot(beNil())
                        expect(self.mockedUserDefaultsRepository.didSaveValue).to(equal(.User))
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
                            expect(self.mockedUserDefaultsRepository.didSaveValue).to(equal(.User))
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
        
        describe("User interactor user info requests") {
            
            it("should return user when requested") {
                waitUntil { (done) in
                    self.subject.fetchUser().done {
                        expect(self.mockedUserDefaultsRepository.didSaveValue).to(equal(.User))
                        expect($0).toNot(beNil())
                        done()
                    }.catch { XCTFail($0.localizedDescription); done() }
                }
            }
            
            it("should return handle request error") {
                let message = "there was an error"
                self.mockedRepository.responseError = .init(message: message)
                
                waitUntil { (done) in
                    self.subject.fetchUser().done({ _ in XCTFail("the request should have failed"); done() })
                        .catch({ expect($0.localizedDescription).to(equal(message)); done() })
                }
                
            }
            
            it("should return saved user when available") {
                self.mockedUserDefaultsRepository.shouldReturnValue = true
                expect(self.subject.savedUser()).toNot(beNil())
            }
            
            it("should return nil when user is not available") {
                self.mockedUserDefaultsRepository.shouldReturnValue = false
                expect(self.subject.savedUser()).to(beNil())
            }
            
        }
        
        describe("User Interactor available user method") {
            
            it("should return if it has user or not") {
                _ = self.mockedKeychain.save(key: "jwt", data: .init())
                expect(self.subject.hasUser()).to(beTrue())
                _ = self.mockedKeychain.delete(key: "jwt")
                expect(self.subject.hasUser()).to(beFalse())
            }
            
        }
        
    }
    
}
