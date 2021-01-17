//
//  LoginPresenterTests.swift
//  PresentationTests
//
//  Created by Renato Lopes on 17/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import XCTest
import Presentation
import Domain
import Data

class LoginPresenterTests: XCTestCase {

    func test_login_should_call_validation_with_correct_values() {
        let validation = ValidationSpy()
        let sut = makeSut(validation: validation)
        let viewModel = makeLoginViewModel()
        sut.login(viewModel: viewModel)
        let expected = NSDictionary(dictionary: viewModel.convertToJson()!).isEqual(validation.data!)
        XCTAssertTrue(expected)
    }
    
    func test_login_should_call_validation_if_validate_fails() {
        let validationSpy = ValidationSpy()
        let alertSpy = AlertViewSpy()
        let promise = expectation(description: "validate fails")
        let presenter = makeSut(alertView: alertSpy, validation: validationSpy)
    
        alertSpy.observer { (viewModel) in
            XCTAssertEqual(viewModel.message, validationSpy.errorMessage)
            promise.fulfill()
        }
        
        let viewModel = makeLoginViewModel()
        validationSpy.simulateError("Erro")
        presenter.login(viewModel: viewModel)
        wait(for: [promise], timeout: 2)
        
    }
    
    func test_login_should_call_authentication_with_correct_values() {
        let authSpy: AuthenticationSpy = AuthenticationSpy()
        let sut = makeSut(authentication: authSpy)
        sut.login(viewModel: makeLoginViewModel())
        XCTAssertEqual(authSpy.authModel,
                       makeAuthenticationModel())
    }
    
    func test_login_should_show_generic_error_message_if_addAccount_fails() {
        let alertViewSpy: AlertViewSpy = AlertViewSpy()
        let authSpy: AuthenticationSpy = AuthenticationSpy()
        let sut = makeSut(alertView: alertViewSpy, authentication: authSpy)
        
        let promise = expectation(description: "authentication fails")
        alertViewSpy.observer { (viewModel) in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes"))
            promise.fulfill()
        }
        sut.login(viewModel: makeLoginViewModel())
        authSpy.completionWithError(.unexpected)
        wait(for: [promise], timeout: 1)
    }
    
    func test_login_should_show_error_expired_session_error_message_if_authentication_fails() {
        let alertViewSpy: AlertViewSpy = AlertViewSpy()
        let authSpy: AuthenticationSpy = AuthenticationSpy()
        let sut = makeSut(alertView: alertViewSpy, authentication: authSpy)
        let promise = expectation(description: "authentication fails")
        alertViewSpy.observer { (viewModel) in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Email e/ou senha inválido(s)."))
            promise.fulfill()
        }
        sut.login(viewModel: makeLoginViewModel())
        authSpy.completionWithError(.expiredSession)
        wait(for: [promise], timeout: 1)
    }
    
    func test_login_should_show_success_message_if_addAccount_succeeds() {
        let alertViewSpy: AlertViewSpy = AlertViewSpy()
        let authSpy: AuthenticationSpy = AuthenticationSpy()
        let sut = makeSut(alertView: alertViewSpy, authentication: authSpy)
        
        let promise = expectation(description: "authentication fails")
        alertViewSpy.observer { (viewModel) in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Sucesso", message: "Login feito com sucesso."))
            promise.fulfill()
        }
        sut.login(viewModel: makeLoginViewModel())
        authSpy.ocmpletionWithSuccess(makeAccountModel())
        wait(for: [promise], timeout: 1)
    }
    
    func test_login_should_show_loading_before_and_after_login() {
        let loadingViewSpy: LoadingViewSpy = LoadingViewSpy()
        let authSpy: AuthenticationSpy = AuthenticationSpy()
        let sut = makeSut(authentication: authSpy, loadingView: loadingViewSpy)
        
        let promiseShowLoading = expectation(description: "Waiting Show Loading")
        loadingViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
            promiseShowLoading.fulfill()
        }
        sut.login(viewModel: makeLoginViewModel())
        wait(for: [promiseShowLoading], timeout: 1)

        let promiseHiddenLoading = expectation(description: "Waiting Hidden Loading")
        loadingViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
            promiseHiddenLoading.fulfill()
        }
        
        authSpy.completionWithError(.unexpected)
        wait(for: [promiseHiddenLoading], timeout: 1)
    }
}

extension LoginPresenterTests {
    // MARK: - Public Methods
    public func makeSut(alertView: AlertView = AlertViewSpy(), authentication: Authentication = AuthenticationSpy(), loadingView: LoadingViewSpy = LoadingViewSpy(), validation: Validation = ValidationSpy()) -> LoginPresenter {
        
        let sut: LoginPresenter = LoginPresenter(alertView: alertView, authentication: authentication, loadingView: loadingView, validation: validation)
        checkMemoryLeak(for: sut)
        return sut
    }
}

class AuthenticationSpy: Authentication {
    var authModel: AuthenticationModel?
    var completion: Authentication.AuthenticationResult?
    
    func auth(with model: AuthenticationModel, completion: @escaping AuthenticationResult) {
        authModel = model
        self.completion = completion
    }
    
    func completionWithError(_ error: DomainError) {
        completion?(.failure(error))
    }
    
    func ocmpletionWithSuccess(_ account: AccountModel) {
        completion?(.success(account))
    }
}
