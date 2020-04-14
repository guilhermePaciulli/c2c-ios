//
//  ExpirationDateComponentsTests.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 13/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import Quick
import Nimble

class ExpirationDateComponentsTests: QuickSpec {
    
    var subject = ExpirationDateComponents()
    
    override func spec() {
        
        beforeEach {
            self.subject = .init()
        }
        
        describe("ExpirationDateComponent behaviour tests") {
            
            it("should initalize years and months successfully") {
                expect(self.subject.years.count).to(equal(11))
                expect(self.subject.months.count).to(equal(12))
                expect(self.subject.years.allSatisfy({ $0.count == 2 })).to(beTrue())
                expect(self.subject.months.allSatisfy({ $0.count == 3 })).to(beTrue())
                expect(self.subject.numberOfItems(inComponent: 0)).to(equal(12))
                expect(self.subject.numberOfItems(inComponent: 1)).to(equal(11))
                expect(self.subject.numberOfComponents()).to(equal(2))
            }
            
            it("should return coherent values") {
                let mInd = 11
                let yInd = 2
                
                let monthValue = self.subject.get(0, atIndex: mInd)
                let yearValue = self.subject.get(1, atIndex: yInd)
                let constructedDate = monthValue + "/" + yearValue
                
                let val = self.subject.getDateFormatted(atMonth: mInd, year: yInd)
                expect(val).to(equal(constructedDate))
                
                let indexes = self.subject.getIndexes(forString: val)
                expect(indexes.month).to(equal(mInd))
                expect(indexes.year).to(equal(yInd))
            }
            
        }
        
    }
    
}
