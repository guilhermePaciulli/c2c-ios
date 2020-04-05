//
//  AccountFieldsTests.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 05/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import Quick
import Nimble

class AccountFieldsTests: QuickSpec {
    
    let validStrings: [AccountFields: String] = [.Email: "rogerinho@inga.com",
                                                 .Password: "12345678",
                                                 .CPF: "41548807800",
                                                 .FirstName: "Rogerinho",
                                                 .Surname: "do Ingá"]
    
    let invalidStrings: [AccountFields: String] = [.Email: "@inga.com",
                                                   .Password: "1234",
                                                   .CPF: "41548807832",
                                                   .FirstName: "rog",
                                                   .Surname: "ing"]
    
    let errors: [AccountFields: String] = [.Email: "Email not valid",
                                           .Password: "Password must be greater than 8 character",
                                           .FirstName: "First name doesn't seem valid",
                                           .Surname: "First name doesn't seem valid",
                                           .CPF: "CPF doens't seem valid"]
    
    
    override func spec() {
        
        describe("AccountFields validation behaviour") {
            
            it("should return the right error when invalid") {
                AccountFields.allCases.forEach { field in
                    expect(field.validate(string: self.invalidStrings[field]!)).to(equal(self.errors[field]!))
                }
            }
            
            it("should return nil when valid") {
                AccountFields.allCases.forEach { field in
                    expect(field.validate(string: self.validStrings[field]!)).to(beNil())
                }
            }
            
        }
        
    }
    
}
