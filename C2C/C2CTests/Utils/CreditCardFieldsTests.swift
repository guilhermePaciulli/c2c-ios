//
//  CreditCardFieldsTests.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 13/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import Quick
import Nimble

class CreditCardFieldsTests: QuickSpec {
    
    let validStrings: [CreditCardFields: String] = [.Number: "4197394215553472",
                                                    .Owner: "August Jefferson",
                                                    .CVV: "858"]
    
    let invalidStrings: [CreditCardFields: String] = [.Number: "4197353472",
                                                      .Owner: "",
                                                      .CVV: "2"]
    
    let errors: [CreditCardFields: String] = [.Number: "The number doesn't seem valid",
                                              .Owner: "The owner doesn't seem valid",
                                              .CVV: "CVV is not valid"]
    
    
    override func spec() {
        
        describe("CreditCardFields validation behaviour") {
            
            it("should return the right error when invalid") {
                CreditCardFields.allCases.forEach { field in
                    expect(field.validate(string: self.invalidStrings[field]!)).to(equal(self.errors[field]!))
                }
            }
            
            it("should return nil when valid") {
                CreditCardFields.allCases.forEach { field in
                    expect(field.validate(string: self.validStrings[field]!)).to(beNil())
                }
            }
            
        }
        
    }
    
}
