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
    
    func mockedPromiseFor<T: Decodable>(object: T.Type, andError error: ResponseError? = nil, withFile name: String? = nil) -> Promise<T> {
        return Promise<T> { seal in
            if let apiError = fetchError {
                seal.reject(ResponseError.api(error: apiError))
            } else if let empty = EmptyResponse() as? T {
                seal.fulfill(empty)
            } else if let jsonData = FilesHelper.loadFileAsData(T.self) {
                returnSeal(seal, jsonData: jsonData)
            } else if let n = name, let jsonData = FilesHelper.loadFileAsData(n) {
                returnSeal(seal, jsonData: jsonData)
            } else {
                seal.reject(ResponseError.jsonConversionFailure)
            }
        }
    }
    
    func returnSeal<T: Decodable>(_ seal: Resolver<T>, jsonData: Data) {
        if let data = try? JSONDecoder().decode(DataDecodable<T>.self, from: jsonData).data {
            seal.fulfill(data)
        } else if let data = try? JSONDecoder().decode(T.self, from: jsonData) {
            seal.fulfill(data)
        } else {
            seal.reject(ResponseError.jsonConversionFailure)
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
    
    static func loadFileAsData(_ fileName: String) -> Data? {
        guard let path = Bundle(for: self).path(forResource: fileName, ofType: "json") else {
            return nil
        }
        return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }
    
}
