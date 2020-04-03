//
//  ProductCoordinatorTests.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 02/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import Quick
import Nimble

class ProductCoordinatorTests: QuickSpec {
    
    var subject = ProductsCoordinator(baseCoordinator: AppCoordinatorMock())
    var mockedAppCoordinator = AppCoordinatorMock()
    
    override func spec() {
        
        beforeEach {
            self.mockedAppCoordinator = AppCoordinatorMock()
            self.subject = .init(baseCoordinator: self.mockedAppCoordinator)
        }
        
        describe("Product coordinator flow tests") {
            
            it("should start ate product list") {
                expect(self.subject.state).to(equal(.ProductsList))
            }
            
            it("should present product detail view") {
                self.subject.presentNextStep()
                expect(self.mockedAppCoordinator.presentedViewController).to(beAKindOf(ProductDetailViewController.self))
                expect(self.subject.state).to(equal(.ProductsDetail))
            }
            
            it("should dismiss product detail view") {
                self.subject.presentNextStep()
                self.subject.presentPreviousStep()
                expect(self.subject.state).to(equal(.ProductsList))
            }
            
        }
        
    }
    
    
}
