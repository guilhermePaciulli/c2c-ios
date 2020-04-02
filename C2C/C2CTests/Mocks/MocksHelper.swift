//
//  APIClientTests.swift
//  C2CTests
//
//  Created by Guilherme Paciulli on 22/03/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

@testable import C2C
import PromiseKit

class APIClientHelper {
    
    var fetchError: APIResponseError? = nil
    
    init(withFetchError error: APIResponseError?) {
        self.fetchError = error
    }
    
    func mockedPromiseFor<T: Codable>(object: T.Type, andError error: ResponseError? = nil) -> Promise<T> {
        return Promise<T> { seal in
            if let apiError = fetchError {
                seal.reject(ResponseError.api(error: apiError))
            } else if let jsonData = FilesHelper.loadFileAsData(T.self) {
                if let data = try? JSONDecoder().decode(DataDecodable<T>.self, from: jsonData).data {
                    seal.fulfill(data)
                } else if let data = try? JSONDecoder().decode(T.self, from: jsonData) {
                    seal.fulfill(data)
                } else {
                    seal.reject(ResponseError.jsonConversionFailure)
                }
            } else if let empty = EmptyResponse() as? T {
                seal.fulfill(empty)
            } else {
                seal.reject(ResponseError.jsonConversionFailure)
            }
        }
    }
}

class FilesHelper {
    
    static func loadFileAsData<T: Decodable>(_ type: T.Type) -> Data? {
        guard let path = Bundle(for: self).path(forResource: String(describing: T.self), ofType: "json") else {
            return nil
        }
        return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }
    
}
