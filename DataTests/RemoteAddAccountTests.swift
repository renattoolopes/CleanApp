//
//  RemoteAddAccountTests.swift
//  DataTests
//
//  Created by Renato Lopes on 07/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import XCTest
import Domain
import Data

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
        sut.add(accountModel: addAccountModel)
        XCTAssertEqual(httpClientSpy.data, addAccountModel.convertToData())
    }
}
extension RemoteAddAccountTests {    
    class HttpClientSpy: HttpPostClient {
        var url: URL?
        var data: Data?

        func post(to url: URL, with data: Data?) {
            self.url = url
            self.data = data
        }
    }
}
