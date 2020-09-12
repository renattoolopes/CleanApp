//
//  AlamofireAdapterTests.swift
//  InfraTests
//
//  Created by Renato Lopes on 10/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import XCTest
import Alamofire

class AlamofireAdapterTests: XCTestCase {
    
    func test_post_should_make_request_with_valid_url_and_method() {
        let url: URL = makeFakeURL()!
        let configuration: URLSessionConfiguration = .default
        configuration.protocolClasses = [URLStubProtocol.self]
        let session: Session = Session(configuration: configuration)
        let alamofireAdapter: AlamofireAdapter = AlamofireAdapter(session: session)
        let promise: XCTestExpectation = XCTestExpectation(description: "Waiting Request")
        URLStubProtocol.observerRequest { (request) in
            XCTAssertEqual(url, request.url!)
            XCTAssertEqual("POST", request.httpMethod)
            XCTAssertNotNil(request.httpBodyStream)
            promise.fulfill()
        }
    
        alamofireAdapter.post(to: url, with: makeValidData())
        wait(for: [promise], timeout: 2)
    }
}

class AlamofireAdapter {
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func post(to url: URL, with data: Data?) {
        guard let data: Data = data,
            let json: [String: Any] = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                return
        }
        session.request(url, method: .post, parameters: json, encoding: JSONEncoding.default).resume()
    }
}

class URLStubProtocol: URLProtocol {
    // Created Observable Pattern
    private static var emit: ((URLRequest) -> Void)? = nil
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        URLStubProtocol.emit?(request)
    }
    
    override func stopLoading() {}
    
    static func observerRequest(completion: @escaping (URLRequest) -> Void) {
        URLStubProtocol.emit = completion
    }
}
