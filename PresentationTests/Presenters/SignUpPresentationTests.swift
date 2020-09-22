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

class SignUpPresentationTests: XCTestCase {
    func test_signup_should_error_message_if_name_is_not_provided() {
        let alertViewSpy: AlertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(viewModel: makeSignUpViewModel(name: nil))
        XCTAssertEqual(alertViewSpy.viewModel, makeRequiredAlertViewModel(withField: "Nome"))
    }
    
    func test_signup_should_error_message_if_email_is_not_provided() {
        let alertViewSpy: AlertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(viewModel: makeSignUpViewModel(email: nil))
        XCTAssertEqual(alertViewSpy.viewModel, makeRequiredAlertViewModel(withField: "Email"))
    }
    
    func test_signup_should_error_message_if_password_is_not_provided() {
        let alertViewSpy: AlertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(viewModel: makeSignUpViewModel(password: nil))
        XCTAssertEqual(alertViewSpy.viewModel, makeRequiredAlertViewModel(withField: "Senha"))
    }
    
    func test_signup_should_error_message_if_password_confirmation_is_not_provided() {
        let alertViewSpy: AlertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: nil))
        XCTAssertEqual(alertViewSpy.viewModel, makeRequiredAlertViewModel(withField: "Confirmar senha"))
    }
    
    func test_signup_should_error_message_if_password_confirmation_is_not_match() {
        let viewModel: SignUpViewModel = makeSignUpViewModel(password: "123",
                                                             passwordConfirmation: "456")
        let alertViewSpy: AlertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertViewSpy.viewModel, makeInvalidAlertViewModel(withField: "Confirmar senha"))
    }
    
    func test_signup_should_call_emailValidator_with_correct_email() {
        let emailValidatorSpy: EmailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(emailValidator: emailValidatorSpy)
        let signUpViewModel: SignUpViewModel = SignUpViewModel(name: "renato", email: "invalid_email@email.com", password: "123", passwordConfirmation: "123")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email)
    }
    
    func test_signup_should_error_message_if_invalid_email_is_provided() {
        let emailValidatorSpy: EmailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(emailValidator: emailValidatorSpy)
        let signUpViewModel: SignUpViewModel = SignUpViewModel(name: "renato", email: "invalid_email@email.com", password: "123", passwordConfirmation: "123")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email)
    }
    
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
        sut.signUp(viewModel: makeSignUpViewModel())
        addAccountSpy.completionWithError(.unexpected)
        XCTAssertEqual(alertViewSpy.viewModel, makeErrorAlertViewModel(withMessage: "Algo inesperado aconteceu, tente novamente em alguns instantes"))
    }
}

extension SignUpPresentationTests {
    // MARK: - Internal Class
    class AlertViewSpy: AlertView {
        // MARK: - Public Properties
        public var viewModel: AlertViewModel?
        
        // MARK: - Public Methods
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
    
    class EmailValidatorSpy: EmailValidator {
        var email: String?
        private var isValid: Bool = true
        
        func isValid(email: String) -> Bool {
            self.email = email
            return isValid
        }
        
        func simulatedInvalidEmail() {
            self.isValid = false
        }
    }
    
    class AddAccountSpy: AddAccount {
        public var addAccountModel: AddAccountModel?
        public var compleiton: AddAccountResult?
        
        func add(account: AddAccountModel, compleiton: @escaping AddAccountResult) {
            self.addAccountModel = account
            self.compleiton = compleiton
        }
        
        func completionWithError(_ error: DomainError) {
            self.compleiton?(.failure(error))
        }
    }
    
    // MARK: - Public Methods
    public func makeSut(alertView: AlertView = AlertViewSpy(), emailValidator: EmailValidator = EmailValidatorSpy(), addAccount: AddAccount = AddAccountSpy()) -> SignUpPresenter {
        let sut: SignUpPresenter = SignUpPresenter(alertView: alertView,emailValidator: emailValidator, addAccount: addAccount)
        return sut
    }
    
    public func makeSignUpViewModel(name: String? = "any_name",
                               email: String? = "any_email",
                               password: String? = "any_password",
                               passwordConfirmation: String? = "any_password") -> SignUpViewModel {
        
        return SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
        
    }
    
    public func makeRequiredAlertViewModel(withField: String) -> AlertViewModel {
        return AlertViewModel(title: "Falha na validação",
                              message: "O campo \(withField) é obrigatorio")
    }
    
    public func makeInvalidAlertViewModel(withField: String) -> AlertViewModel {
        return AlertViewModel(title: "Falha na validação",
                              message: "O campo \(withField) é inválido")
    }
    
    public func makeErrorAlertViewModel(withMessage message: String) -> AlertViewModel {
        return AlertViewModel(title: "Error", message: message)
    }
}
