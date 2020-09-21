//
//  AlamofireAdapterTests.swift
//  InfraTests
//
//  Created by Renato Lopes on 10/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import XCTest
import Data
import Infra
import Alamofire

class AlamofireAdapterTests: XCTestCase {
    
    func test_post_should_make_request_with_valid_url_and_method() {
        let url: URL = makeFakeURL()!
        let alamofireAdapter: AlamofireAdapter = makeSut()
        let promise: XCTestExpectation = XCTestExpectation(description: "Waiting Request")
        URLStubProtocol.observerRequest { (request) in
            XCTAssertEqual(url, request.url!)
            XCTAssertEqual("POST", request.httpMethod)
            XCTAssertNotNil(request.httpBodyStream)
        }
    
        alamofireAdapter.post(to: url, with: makeValidData(), completion: {_ in promise.fulfill() })
        wait(for: [promise], timeout: 2)
    }
    
    func test_post_should_make_request_with_invalid_data() {
        let alamofireAdapter: AlamofireAdapter = makeSut()
        let promise: XCTestExpectation = XCTestExpectation(description: "Waiting Request")
        URLStubProtocol.observerRequest { (request) in
            XCTAssertNil(request.httpBodyStream)
        }
        alamofireAdapter.post(to: makeFakeURL()!, with: nil, completion: { _ in promise.fulfill() })
        wait(for: [promise], timeout: 2)
    }
    
    func test_post_should_complete_with_error_when_request_completes_with_error() {
        self.expectResult(expectResult: .failure(.noConnectivity), when: (data: nil, response: nil, error: makeError()))
    }
    
    func test_post_should_complete_with_error_on_all_invalid_cases() {
        self.expectResult(expectResult: .failure(.noConnectivity), when: (data: makeValidData(), response: makeResponse(statusCode: 200), error: makeError()))
        self.expectResult(expectResult: .failure(.noConnectivity), when: (data: makeValidData(), response: nil, error: makeError()))
        self.expectResult(expectResult: .failure(.noConnectivity), when: (data: makeValidData(), response: nil, error: nil))
        self.expectResult(expectResult: .failure(.noConnectivity), when: (data: nil, response: makeResponse(statusCode: 200), error: makeError()))
        self.expectResult(expectResult: .failure(.noConnectivity), when: (data: nil, response: makeResponse(statusCode: 200), error: nil))
        self.expectResult(expectResult: .failure(.noConnectivity), when: (data: nil, response: nil, error: nil))

    }
    
    func test_post_should_complete_with_data_when_completes_with_status_code_200() {
        self.expectResult(expectResult: .success(makeValidData()), when: (data: makeValidData(), response: makeResponse(statusCode: 200), error: nil))
    }
    
    func test_post_should_complete_with_error_when_completes_with_status_code() {
        self.expectResult(expectResult: .failure(.badRequest), when: (data: makeValidData(), response: makeResponse(statusCode: 400), error: nil))
        self.expectResult(expectResult: .failure(.serverError), when: (data: makeValidData(), response: makeResponse(statusCode: 500), error: nil))
        self.expectResult(expectResult: .failure(.forbidden), when: (data: makeValidData(), response: makeResponse(statusCode: 403), error: nil))
        self.expectResult(expectResult: .failure(.unauthorized), when: (data: makeValidData(), response: makeResponse(statusCode: 401), error: nil))
        self.expectResult(expectResult: .failure(.noConnectivity), when: (data: makeValidData(), response: makeResponse(statusCode: 300), error: nil))
    }
    
    func test_post_should_complete_with_non_data_when_completes_with_status_code_204() {
        self.expectResult(expectResult: .success(nil), when: (data: nil, response: makeResponse(statusCode: 204), error: nil))
        self.expectResult(expectResult: .success(nil), when: (data: makeEmptyData(), response: makeResponse(statusCode: 204), error: nil))
        self.expectResult(expectResult: .success(nil), when: (data: makeValidData(), response: makeResponse(statusCode: 204), error: nil))
    }
}

extension AlamofireAdapterTests {
    func makeSut() -> AlamofireAdapter{
        let configuration: URLSessionConfiguration = .default
        configuration.protocolClasses = [URLStubProtocol.self]
        let session: Session = Session(configuration: configuration)
        let sut: AlamofireAdapter = AlamofireAdapter(session: session)
        checkMemoryLeak(for: sut)
        return sut
    }
    
    func expectResult(expectResult: Result<Data?, HttpClientError>, when stub: (data: Data?, response: HTTPURLResponse?, error: Error?), file: StaticString = #file, line: UInt = #line) {
        let sut: AlamofireAdapter = makeSut()
        URLStubProtocol.simulate(data: stub.data, response: stub.response, error: stub.error)
        let promise: XCTestExpectation = XCTestExpectation(description: "Expect Result")
        sut.post(to: makeFakeURL()!, with: stub.data) { (received) in
            switch (expectResult, received) {
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedData), .success(let receivedData)):
                XCTAssertEqual(expectedData, receivedData, file: file, line: line)
            default: XCTFail(file: file, line: line)
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 2.0)
    }
}


