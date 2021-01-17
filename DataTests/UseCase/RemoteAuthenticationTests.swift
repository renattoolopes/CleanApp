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
    func teste_auth_should_httpClient_with_correct_url() {
        // "sut" is used to identifier which object is been tested
        let (sut, httpClientSpy) = makeSut()
        sut.auth(with: makeAuthenticationModel(), completion: { _ in })
        XCTAssertEqual(httpClientSpy.url, [makeFakeURL()!])
    }
    
    func teste_auth_should_call_httpClient_with_correct_data() {
        let (sut, httpClientSpy) = makeSut()
        sut.auth(with: makeAuthenticationModel(), completion: { _ in})
        XCTAssertEqual(httpClientSpy.data, makeAuthenticationModel().convertToData())
    }
    
    func test_auth_should_complete_with_error_if_client_fails() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut: sut, completeWith: .failure(.unexpected)) {
            httpClientSpy.forceFailureWithError()
        }
    }
    
    func test_auth_should_complete_with_expired_sesion_error_if_client_completes_with_unauthorized() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut: sut, completeWith: .failure(.expiredSession)) {
            httpClientSpy.forceFailureWithError(error: .unauthorized)
        }
    }
    
    func test_auth_should_complete_with_account_if_client_completes_with_data() {
        // "sut" is used to identifier which object is been tested
        let (sut, httpClientSpy) = makeSut()
        let expectedAccount: AccountModel = makeAccountModel()
        expect(sut: sut, completeWith: .success(expectedAccount)) {
            httpClientSpy.forceCompletWithData(expectedAccount.convertToData()!)
        }
    }
    
    func test_auth_should_complete_with_account_if_client_completes_with_invalid_data() {
        // "sut" is used to identifier which object is been tested
        let (sut, httpClientSpy) = makeSut()
        expect(sut: sut, completeWith: .failure(.unexpected)) {
            httpClientSpy.forceCompletWithData(makeInvalidData())
        }
    }
    
    func test_auth_should_not_complete_when_sut_is_nil() {
        let httpClientSpy: HttpClientSpy = HttpClientSpy()
        var sut: RemoteAuthentication? = RemoteAuthentication(url: makeFakeURL()!, httpClient: httpClientSpy)
        var completionNil: Result<AccountModel,DomainError>?
        sut?.auth(with: makeAuthenticationModel(), completion: { completionNil = $0})
        sut = nil
        httpClientSpy.forceFailureWithError()
        XCTAssertNil(completionNil)
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
    
    private func expect(sut: RemoteAuthentication, completeWith expected: Result<AccountModel, DomainError>, whenExecute action: () -> Void) {
        let expec = expectation(description: "complete with error if client fails")
        sut.auth(with: makeAuthenticationModel()) { result in
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



public class RemoteAuthentication: Authentication {
    // MARK: - Public Properties
    public var url: URL
    public var httpClient: HttpPostClient
    
    // MARK: - Initializers
    public init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func auth(with model: AuthenticationModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
        httpClient.post(to: url, with: model.convertToData()) {[weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let data):
                if let accountModel: AccountModel = data?.convertToModel() {
                    completion(.success(accountModel))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure(let error):
                switch error {
                case .unauthorized:
                    completion(.failure(.expiredSession))
                default:
                    completion(.failure(.unexpected))
                }
            }
        }
    }
}
