//
//  PromiseKit+Utils.swift
//  C2C
//
//  Created by Guilherme Paciulli on 09/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import PromiseKit

extension Promise {
    internal func `catch`(on: DispatchQueue? = conf.Q.return, _ body: @escaping (ResponseError) -> Void) {
        self.catch(on: on, flags: nil, policy: .allErrors, { (error) in
            body((error as? ResponseError) ?? .server)
        })
    }
}
