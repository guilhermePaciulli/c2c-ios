//
//  Endpoint+FormData.swift
//  C2C
//
//  Created by Guilherme Paciulli on 05/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

protocol FormDatable {
    var parameters: [String: Any] { get }
    var images: [String: UIImage] { get }
}

extension Endpoint {
    
    func createFormDataFrom(model: FormDatable) -> Data {
        let body = NSMutableData()
        let boundaryPrefix = "--\(boundary)\r\n"
        
        model.parameters.forEach({
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\($0.key)\"\r\n\r\n")
            body.appendString("\($0.value)\r\n")
        })

        model.images.forEach({
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\($0.key)\"\r\n")
            body.appendString("Content-Type: \(mimeType)\r\n\r\n")
            body.append($0.value.jpegData(compressionQuality: 0.7) ?? .init())
            body.appendString("\r\n")
        })
        body.appendString("--".appending(boundary.appending("--")))
        
        return body as Data
    }
        
    private var mimeType: String {
        return "image/jpg"
    }
    
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: .utf8, allowLossyConversion: false)
        append(data ?? .init())
    }
}
