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
        sut.add(account: addAccountModel) { (_) in }
        XCTAssertEqual(httpClientSpy.url, [url!])
    }
    
    func teste_add_should_httpClient_with_correct_data() {
        let url: URL? = URL(string: "https://any-url.com")
        XCTAssertNotNil(url)
        let sut: RemoteAddAccount = RemoteAddAccount(url: url!,
                                                     httpPostClient: httpClientSpy)
        sut.add(account: addAccountModel) { _ in }
        XCTAssertEqual(httpClientSpy.data, addAccountModel.convertToData())
    }
    
    func test_add_should_complete_with_error_if_client_fails() {
        // "sut" is used to identifier which object is been tested
        let url: URL? = URL(string: "https://any-url.com")
        XCTAssertNotNil(url)
        let sut: RemoteAddAccount = RemoteAddAccount(url: url!, httpPostClient: httpClientSpy)
        let expec = expectation(description: "complete with error if client fails")
        sut.add(account: addAccountModel) { result in
            if case let Result.failure(error) = result {
                XCTAssertEqual(error, .unexpected)
                expec.fulfill()
            } else {
                XCTFail("Expected DomainError")
            }
        }
        httpClientSpy.forceFailureWithError()
        
        wait(for: [expec], timeout: 1)
    }
    
    func test_add_should_complete_with_account_if_client_completes_with_data() {
        // "sut" is used to identifier which object is been tested
        let url: URL? = URL(string: "https://any-url.com")
        XCTAssertNotNil(url)
        let sut: RemoteAddAccount = RemoteAddAccount(url: url!, httpPostClient: httpClientSpy)
        let expec = expectation(description: "complete with error if client fails")
        let expectedAccount: AccountModel = makeAccountModel()
        sut.add(account: addAccountModel) { result in
            if case let Result.success(receivedAccount) = result {
                XCTAssertEqual(receivedAccount, expectedAccount)
            } else {
                XCTFail("Expected DomainError")
            }
            expec.fulfill()
        }
        httpClientSpy.forceCompletWithData(expectedAccount.convertToData()!)
        
        wait(for: [expec], timeout: 1)
    }
    
    func test_add_should_complete_with_account_if_client_completes_with_invalid_data() {
        // "sut" is used to identifier which object is been tested
        let url: URL? = URL(string: "https://any-url.com")
        XCTAssertNotNil(url)
        let sut: RemoteAddAccount = RemoteAddAccount(url: url!, httpPostClient: httpClientSpy)
        let expec = expectation(description: "complete with error if client fails")
        sut.add(account: addAccountModel) { result in
            if case let Result.failure(error) = result {
                XCTAssertEqual(error, .unexpected)
            } else {
                XCTFail("Expected Error")
            }
            expec.fulfill()
        }
        httpClientSpy.forceCompletWithData(Data("Invalid_data".utf8))
        
        wait(for: [expec], timeout: 1)
    }
}

extension RemoteAddAccountTests {
    private func makeAccountModel() -> AccountModel {
        return AccountModel(id: "100",
                            name: "Renato Lopes",
                            email: "renattoolopes@gmail.com",
                            password: "123123")
    }
}

extension RemoteAddAccountTests {    
    class HttpClientSpy: HttpPostClient {
        var url: [URL] = [URL]()
        var data: Data?
        var completion: ((Result<Data, HttpClientError>) -> Void)?
        
        func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, HttpClientError>) -> Void) {
            self.url.append(url)
            self.data = data
            self.completion = completion
        }
        
        func forceFailureWithError() {
            completion?(.failure(.noConnectivity))
        }
        
        func forceCompletWithData(_ data: Data) {
            completion?(.success(data))
        }
    }
}
