//
//  AddressFieldsTests.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 11/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import Quick
import Nimble

class AddressFieldsTests: QuickSpec {
    
    let validStrings: [AddressFields: String] = [.ZipCode: "3213123-323",
                                                 .Number: "234",
                                                 .Complement: "apt 56"]
    
    let invalidStrings: [AddressFields: String] = [.ZipCode: "",
                                                   .Number: "-3",
                                                   .Complement: ""]
    
    let errors: [AddressFields: String] = [.ZipCode: "ZipCode must not be empty",
                                           .Complement: "Address line 2 seems invalid",
                                           .Number: "Address number is not valid"]
    
    
    override func spec() {
        
        describe("AddressFields validation behaviour") {
            
            it("should return the right error when invalid") {
                AddressFields.allCases.forEach { field in
                    expect(field.validate(string: self.invalidStrings[field]!)).to(equal(self.errors[field]!))
                }
            }
            
            it("should return nil when valid") {
                AddressFields.allCases.forEach { field in
                    expect(field.validate(string: self.validStrings[field]!)).to(beNil())
                }
            }
            
        }
        
    }
    
}
