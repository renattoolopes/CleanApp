//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Renato Lopes on 20/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import XCTest
import Presentation
import Domain
import Data

class SignUpPresentationTests: XCTestCase {
    
    func test_signup_should_call_addAccount_with_correct_values() {
        let addAccountSpy: AddAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy)
        sut.signUp(viewModel: makeSignUpViewModel())
        XCTAssertEqual(addAccountSpy.addAccountModel,
                       makeAddAccountModel())
    }
    
    func test_singUp_should_show_error_message_if_addAccount_fails() {
        let alertViewSpy: AlertViewSpy = AlertViewSpy()
        let addAccountSpy: AddAccountSpy = AddAccountSpy()
        let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
        let promise = expectation(description: "add account fails")
        alertViewSpy.observer { (viewModel) in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes"))
            promise.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel())
        addAccountSpy.completionWithError(.unexpected)
        wait(for: [promise], timeout: 1)
    }
    
    func test_singUp_should_show_loading_before_and_after_addAccount() {
        let loadingViewSpy: LoadingViewSpy = LoadingViewSpy()
        let addAccountSpy: AddAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy, loadingView: loadingViewSpy)
        
        let promiseShowLoading = expectation(description: "Waiting Show Loading")
        loadingViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
            promiseShowLoading.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel())
        wait(for: [promiseShowLoading], timeout: 1)

        let promiseHiddenLoading = expectation(description: "Waiting Hidden Loading")
        loadingViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
            promiseHiddenLoading.fulfill()
        }
        
        addAccountSpy.completionWithError(.unexpected)
        wait(for: [promiseHiddenLoading], timeout: 1)
    }
    
    func test_singUp_should_show_success_message_if_addAccount_succeeds() {
        let alertViewSpy: AlertViewSpy = AlertViewSpy()
        let addAccountSpy: AddAccountSpy = AddAccountSpy()
        let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
        let promise = expectation(description: "add account")
        alertViewSpy.observer { (viewModel) in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Sucesso", message: "Conta criada com sucesso!"))
            promise.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel())
        addAccountSpy.completeWithAccountSpy(makeAccountModel())
        wait(for: [promise], timeout: 1)
    }

    func test_signUp_should_call_validation_with_correct_values() {
        let validation = ValidationSpy()
        let sut = makeSut(validation: validation)
        let viewModel = makeSignUpViewModel()
        sut.signUp(viewModel: viewModel)
        let expected = NSDictionary(dictionary: viewModel.convertToJson()!).isEqual(validation.data!)
        XCTAssertTrue(expected)
    }
    
    func test_signUp_should_call_validation_if_validate_fails() {
        let validationSpy = ValidationSpy()
        let alertSpy = AlertViewSpy()
        let promise = expectation(description: "validate fails")
        let presenter = makeSut(alertView: alertSpy, validation: validationSpy)
    
        alertSpy.observer { (viewModel) in
            XCTAssertEqual(viewModel.message, validationSpy.errorMessage)
            promise.fulfill()
        }
        let signViewModel = makeSignUpViewModel()
        validationSpy.simulateError("Erro")
        presenter.signUp(viewModel: signViewModel)
        wait(for: [promise], timeout: 2)
        
    }
    
}

extension SignUpPresentationTests {    
    // MARK: - Public Methods
    public func makeSut(alertView: AlertView = AlertViewSpy(), addAccount: AddAccount = AddAccountSpy(), loadingView: LoadingViewSpy = LoadingViewSpy(), validation: Validation = ValidationSpy()) -> SignUpPresenter {
        
        let sut: SignUpPresenter = SignUpPresenter(alertView: alertView, addAccount: addAccount, loadingView: loadingView, validation: validation)
        checkMemoryLeak(for: sut)
        return sut
    }
}

class ValidationSpy: Validation {
    var data: [String: Any]?
    var errorMessage: String?
    
    func validate(data: [String: Any]?) -> String? {
        self.data = data
        return errorMessage
    }
    
    func simulateError(_ error: String) {
        errorMessage = error
    }
}
