//
//  LoginViewModelTests.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 02/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import Quick
import Nimble

class LoginViewModelTests: QuickSpec {
    
    var subject = AuthenticationViewModel()
    
    override func spec() {
        
        beforeEach {
            self.subject = AuthenticationViewModel()
        }
        
    }
    
}
