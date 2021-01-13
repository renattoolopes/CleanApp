//
//  RemoteAuthenticationTests.swift
//  DataTests
//
//  Created by Renato Lopes on 13/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import XCTest
import Domain
import Data

class RemoteAuthenticationTests: XCTestCase {
    func teste_add_should_httpClient_with_correct_url() {
        // "sut" is used to identifier which object is been tested
        let (sut, httpClientSpy) = makeSut()
        sut.auth(with: makeAuthenticationModel())
        XCTAssertEqual(httpClientSpy.url, [makeFakeURL()!])
    }
    
    func teste_add_should_call_httpClient_with_correct_data() {
        let (sut, httpClientSpy) = makeSut()
        sut.auth(with: makeAuthenticationModel())
        XCTAssertEqual(httpClientSpy.data, makeAuthenticationModel().convertToData())
    }
}

extension RemoteAuthenticationTests {
    private func makeSut(file: StaticString = #file, andLine line: UInt = #line) -> (sut: RemoteAuthentication, httpSpy: HttpClientSpy) {
        let httpClientSpy: HttpClientSpy = HttpClientSpy()
        let sut: RemoteAuthentication = RemoteAuthentication(url: makeFakeURL()!, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut)
        checkMemoryLeak(for: httpClientSpy, inFile: file, andLine: line)
        return (sut, httpClientSpy)
    }
}



public class RemoteAuthentication {
    // MARK: - Public Properties
    public var url: URL
    public var httpClient: HttpPostClient
    
    // MARK: - Initializers
    public init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func auth(with model: AuthenticationModel) {
        httpClient.post(to: url, with: model.convertToData()) {_ in }
    }
}
