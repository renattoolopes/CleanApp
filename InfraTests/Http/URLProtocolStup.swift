//
//  URLProtocolStup.swift
//  InfraTests
//
//  Created by Renato Lopes on 20/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation

class URLStubProtocol: URLProtocol {
    // Created Observable Pattern
    private static var emit: ((URLRequest) -> Void)? = nil
    static var error: Error?
    static var data: Data?
    static var response: HTTPURLResponse?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    static func simulate(data: Data?, response: HTTPURLResponse?, error: Error?) {
        URLStubProtocol.error = error
        URLStubProtocol.response = response
        URLStubProtocol.data = data
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        URLStubProtocol.emit?(request)
        if let data: Data = URLStubProtocol.data {
            client?.urlProtocol(self, didLoad: data)
        }
        
        if let response: HTTPURLResponse = URLStubProtocol.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        if let error: Error = URLStubProtocol.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
    
    static func observerRequest(completion: @escaping (URLRequest) -> Void) {
        URLStubProtocol.emit = completion
    }
}
