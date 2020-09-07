//
//  RemoteAddAccountTests.swift
//  DataTests
//
//  Created by Renato Lopes on 07/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import XCTest

class RemoteAddAccountTests: XCTestCase {
    func teste_add_should_httpClient_with_correct_url() {
        // "sut" is used to identifier which object is been tested
        let url: URL? = URL(string: "https://any-url.com")
        XCTAssertNotNil(url)
        let httpClientPostSpy: HttpClientSpy = HttpClientSpy()
        let sut: RemoteAddAccount = RemoteAddAccount(url: url!, httpPostClient: httpClientPostSpy)
        sut.add()
        XCTAssertEqual(httpClientPostSpy.url, url)
    }
}

class RemoteAddAccount {
    var url: URL
    var httpPostClient: HttpPostClient
    
    init(url: URL, httpPostClient: HttpPostClient) {
        self.url = url
        self.httpPostClient = httpPostClient
    }
    
    func add() {
        self.httpPostClient.post(url: self.url)
    }
}
protocol HttpPostClient {
    func post(url: URL)
}

class HttpClientSpy: HttpPostClient {
    var url: URL?

    func post(url: URL) {
        self.url = url
    }
}
