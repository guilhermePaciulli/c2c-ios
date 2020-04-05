//
//  AuthenticationCoordinationMock.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 05/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C

class AuthenticationCoordinationMock: AuthenticationCoordinationProtocol {
    
    var didLoginCalled = false
    var presentNextStepCalled = false
    var presentPreviousStepCalled = false
    
    func didLogin() {
        didLoginCalled = true
    }
    
    func presentNextStep() {
        presentNextStepCalled = true
    }
    
    func presentPreviousStep() {
        presentPreviousStepCalled = true
    }
    
}
