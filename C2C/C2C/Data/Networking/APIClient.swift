//
//  Networking.swift
//  C2C
//
//  Created by Guilherme Paciulli on 09/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import PromiseKit
import UIKit

private var session: URLSession = .shared

protocol APIClient {
    func dispatchRequest<T: Decodable>(with request: URLRequest, decodingType: T.Type) -> Promise<T>
}

extension APIClient {
    
    func dispatchRequest<T: Decodable>(with request: URLRequest, decodingType: T.Type) -> Promise<T> {
        
        return firstly { session.dataTask(.promise, with: request) }.map({ data, response in
            guard let httpResponse = response as? HTTPURLResponse else { throw ResponseError.timeout }
            
            guard 200...299 ~= httpResponse.statusCode else {
                if let apiResponseError = try? JSONDecoder().decode(APIResponseError.self, from: data) {
                    throw ResponseError.api(error: apiResponseError)
                }
                throw ResponseError.server
            }
            do {
                return try JSONDecoder().decode(DataDecodable<T>.self, from: data).data
            } catch {
                throw ResponseError.jsonConversionFailure
            }
        }).recover({  (error) -> Promise<T> in
            if let treatableError = error as? ResponseError { throw treatableError }
            throw ResponseError.timeout
        })
    }
}

struct DataDecodable<T: Decodable>: Decodable {
    let data: T
}
