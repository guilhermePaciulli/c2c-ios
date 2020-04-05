//
//  CoordinationMocks.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 02/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C

class BasicCoordinatorMock: BasicCoordinationProtocol {
    
    var didCallPresentNextStep = false
    var didCallPresentPreviousStep = false
    
    func presentNextStep() {
        didCallPresentNextStep = true
    }
    
    func presentPreviousStep() {
        didCallPresentPreviousStep = true
    }    
}
