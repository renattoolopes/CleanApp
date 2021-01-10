//
//  HttpClientSpy.swift
//  DataTests
//
//  Created by Renato Lopes on 10/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation
import Data
public class HttpClientSpy: HttpPostClient {
    
    // MARK: - Public Properties
    public var url: [URL] = [URL]()
    public var data: Data?
    public var completion: ((Result<Data?, HttpClientError>) -> Void)?
    
    // MARK: - Public Methods
    public func post(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HttpClientError>) -> Void) {
        self.url.append(url)
        self.data = data
        self.completion = completion
    }
    
    public func forceFailureWithError(error: HttpClientError = .noConnectivity) {
        completion?(.failure(error))
    }
    
    public func forceCompletWithData(_ data: Data) {
        completion?(.success(data))
    }
}
