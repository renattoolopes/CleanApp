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
        let url: URL? = makeFakeURL()
        XCTAssertNotNil(url)
        let sut: RemoteAddAccount = RemoteAddAccount(url: url!, httpPostClient: httpClientSpy)
        sut.add(account: addAccountModel) { (_) in }
        XCTAssertEqual(httpClientSpy.url, [url!])
    }
    
    func teste_add_should_httpClient_with_correct_data() {
        let url: URL? = makeFakeURL()
        XCTAssertNotNil(url)
        let sut: RemoteAddAccount = RemoteAddAccount(url: url!,
                                                     httpPostClient: httpClientSpy)
        sut.add(account: addAccountModel) { _ in }
        XCTAssertEqual(httpClientSpy.data, addAccountModel.convertToData())
    }
    
    func test_add_should_complete_with_error_if_client_fails() {
        // "sut" is used to identifier which object is been tested
        let url: URL? = makeFakeURL()
        XCTAssertNotNil(url)
        let sut: RemoteAddAccount = RemoteAddAccount(url: url!, httpPostClient: httpClientSpy)
        expect(sut: sut, completeWith: .failure(.unexpected)) {
            httpClientSpy.forceFailureWithError()
        }
    }
    
    func test_add_should_complete_with_account_if_client_completes_with_data() {
        // "sut" is used to identifier which object is been tested
        let url: URL? = makeFakeURL()
        XCTAssertNotNil(url)
        let sut: RemoteAddAccount = RemoteAddAccount(url: url!, httpPostClient: httpClientSpy)
        let expectedAccount: AccountModel = makeAccountModel()
        expect(sut: sut, completeWith: .success(expectedAccount)) {
            httpClientSpy.forceCompletWithData(expectedAccount.convertToData()!)
        }
    }
    
    func test_add_should_complete_with_account_if_client_completes_with_invalid_data() {
        // "sut" is used to identifier which object is been tested
        let url: URL? = makeFakeURL()
        XCTAssertNotNil(url)
        let sut: RemoteAddAccount = RemoteAddAccount(url: url!, httpPostClient: httpClientSpy)
        expect(sut: sut, completeWith: .failure(.unexpected)) {
            httpClientSpy.forceCompletWithData(makeInvalidData())
        }
    }
}

extension RemoteAddAccountTests {
    private func makeAccountModel() -> AccountModel {
        return AccountModel(id: "100",
                            name: "Renato Lopes",
                            email: "renattoolopes@gmail.com",
                            password: "123123")
    }
    
    private func makeInvalidData() -> Data {
        return Data("Invalid_data".utf8)
    }
    
    private func makeFakeURL() -> URL {
        return URL(string: "https://any-url.com")
    }
    
    private func expect(sut: RemoteAddAccount, completeWith expected: Result<AccountModel, DomainError>, whenExecute action: () -> Void) {
        let expec = expectation(description: "complete with error if client fails")
        sut.add(account: addAccountModel) { result in
            switch (expected, result) {
            case (.failure(let expectedError), .failure(let resultError)):
                XCTAssertEqual(expectedError, resultError)
            case (.success(let expetedAccount), .success(let resultAccount)):
                XCTAssertEqual(expetedAccount, resultAccount)
            default: XCTFail("Expected \(expected), but was returned \(result)")
            }
            expec.fulfill()
        }
        action()
        wait(for: [expec], timeout: 1)

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
