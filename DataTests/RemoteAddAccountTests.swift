//
//  RemoteAddAccountTests.swift
//  DataTests
//
//  Created by Renato Lopes on 07/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import XCTest
import Domain

class RemoteAddAccountTests: XCTestCase {
    let addAccountModel = AddAccountModel(name: "Renato",
                                           email: "renattoolopes@gmail.com",
                                           password: "123",
                                           passwordConfirmation: "123")
    
    let httpClientSpy: HttpClientSpy = HttpClientSpy()
    
    func teste_add_should_httpClient_with_correct_url() {
        // "sut" is used to identifier which object is been tested
        let url: URL? = URL(string: "https://any-url.com")
        XCTAssertNotNil(url)
        let sut: RemoteAddAccount = RemoteAddAccount(url: url!, httpPostClient: httpClientSpy)
        sut.add(accountModel: addAccountModel)
        XCTAssertEqual(httpClientSpy.url, url)
    }
    
    func teste_add_should_httpClient_with_correct_data() {
        let url: URL? = URL(string: "https://any-url.com")
        XCTAssertNotNil(url)
        let sut: RemoteAddAccount = RemoteAddAccount(url: url!,
                                                     httpPostClient: httpClientSpy)
        let data: Data? = convertToData(addAccountModel: addAccountModel)
        XCTAssertNotNil(data)
        sut.add(accountModel: addAccountModel)
        XCTAssertEqual(data, httpClientSpy.data)
    }
}

extension RemoteAddAccountTests {
    private func convertToData(addAccountModel: AddAccountModel) -> Data? {
        return try? JSONEncoder().encode(addAccountModel)
    }
    
    // User Case
    class RemoteAddAccount {
        var url: URL
        var httpPostClient: HttpPostClient
        
        init(url: URL, httpPostClient: HttpPostClient) {
            self.url = url
            self.httpPostClient = httpPostClient
        }
        
        func add(accountModel: AddAccountModel) {
            let data: Data? = try? JSONEncoder().encode(accountModel)
            self.httpPostClient.post(to: self.url, with: data)
        }
    }

    class HttpClientSpy: HttpPostClient {
        var url: URL?
        var data: Data?

        func post(to url: URL, with data: Data?) {
            self.url = url
            self.data = data
        }
    }
}

// MARK: - Protocols
protocol HttpPostClient {
    func post(to url: URL, with data: Data?)
}
