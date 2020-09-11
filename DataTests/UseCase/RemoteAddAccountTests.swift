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
    func teste_add_should_httpClient_with_correct_url() {
        // "sut" is used to identifier which object is been tested
        let (sut, httpClientSpy) = makeSut()
        sut.add(account: makeAddAccountModel()) { (_) in }
        XCTAssertEqual(httpClientSpy.url, [makeFakeURL()!])
    }
    
    func teste_add_should_httpClient_with_correct_data() {
        let (sut, httpClientSpy) = makeSut()
        sut.add(account: makeAddAccountModel()) { _ in }
        XCTAssertEqual(httpClientSpy.data, makeAddAccountModel().convertToData())
    }
    
    func test_add_should_complete_with_error_if_client_fails() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut: sut, completeWith: .failure(.unexpected)) {
            httpClientSpy.forceFailureWithError()
        }
    }
    
    func test_add_should_complete_with_account_if_client_completes_with_data() {
        // "sut" is used to identifier which object is been tested
        let (sut, httpClientSpy) = makeSut()
        let expectedAccount: AccountModel = makeAccountModel()
        expect(sut: sut, completeWith: .success(expectedAccount)) {
            httpClientSpy.forceCompletWithData(expectedAccount.convertToData()!)
        }
    }
    
    func test_add_should_complete_with_account_if_client_completes_with_invalid_data() {
        // "sut" is used to identifier which object is been tested
        let (sut, httpClientSpy) = makeSut()
        expect(sut: sut, completeWith: .failure(.unexpected)) {
            httpClientSpy.forceCompletWithData(makeInvalidData())
        }
    }
    
    func test_add_should_not_complete_when_sut_is_nil() {
        let httpClientSpy: HttpClientSpy = HttpClientSpy()
        var sut: RemoteAddAccount? = RemoteAddAccount(url: makeFakeURL()!, httpPostClient: httpClientSpy)
        var completionNil: Result<AccountModel,DomainError>?
        sut?.add(account: makeAddAccountModel()) { completionNil = $0 }
        sut = nil
        httpClientSpy.forceFailureWithError()
        XCTAssertNil(completionNil)
    }
}

extension RemoteAddAccountTests {
    private func makeSut(file: StaticString = #file, andLine line: UInt = #line) -> (sut: RemoteAddAccount, httpSpy: HttpClientSpy) {
        let httpClientSpy: HttpClientSpy = HttpClientSpy()
        let sut: RemoteAddAccount = RemoteAddAccount(url: makeFakeURL()!, httpPostClient: httpClientSpy)
        checkMemoryLeak(for: sut)
        checkMemoryLeak(for: httpClientSpy, inFile: file, andLine: line)
        return (sut, httpClientSpy)
    }
    
    private func makeAddAccountModel() -> AddAccountModel {
        return  AddAccountModel(name: "Renato",
                                email: "renattoolopes@gmail.com",
                                password: "123",
                                passwordConfirmation: "123")
    }
    
    private func makeFakeURL() -> URL? {
        return URL(string: "https://any-url.com")
    }
    
    private func expect(sut: RemoteAddAccount, completeWith expected: Result<AccountModel, DomainError>, whenExecute action: () -> Void) {
        let expec = expectation(description: "complete with error if client fails")
        sut.add(account: makeAddAccountModel()) { result in
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
