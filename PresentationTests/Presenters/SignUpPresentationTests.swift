//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Renato Lopes on 20/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import XCTest
import Presentation

class SignUpPresentationTests: XCTestCase {
    func test_signup_should_error_message_if_name_is_not_provided() {
        let alertViewSpy: AlertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(viewModel: makeSignUpViewModel(name: nil))
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Nome é obrigatorio"))
    }
    
    func test_signup_should_error_message_if_email_is_not_provided() {
        let alertViewSpy: AlertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(viewModel: makeSignUpViewModel(email: nil))
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Email é obrigatorio"))
    }
    
    func test_signup_should_error_message_if_password_is_not_provided() {
        let alertViewSpy: AlertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(viewModel: makeSignUpViewModel(password: nil))
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Senha é obrigatorio"))
    }
    
    func test_signup_should_error_message_if_password_confirmation_is_not_provided() {
        let alertViewSpy: AlertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: nil))
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Confirmar senha é obrigatorio"))
    }
    
    func test_signup_should_error_message_if_password_confirmation_is_not_match() {
        let viewModel: SignUpViewModel = makeSignUpViewModel(password: "123",
                                                             passwordConfirmation: "456")
        let alertViewSpy: AlertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "Falha ao Confirmar senha"))
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
        let alertViewSpy: AlertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
        emailValidatorSpy.isValid = false
        let viewModel: SignUpViewModel = makeSignUpViewModel()
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "Email inválido"))
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
    
    public class EmailValidatorSpy: EmailValidator {
        var email: String?
        var isValid: Bool = true
        func isValid(email: String) -> Bool {
            self.email = email
            return isValid
        }
    }
    
    // MARK: - Public Methods
    public func makeSut(alertView: AlertView = AlertViewSpy(), emailValidator: EmailValidator = EmailValidatorSpy()) -> SignUpPresenter {
        let sut: SignUpPresenter = SignUpPresenter(alertView: alertView, emailValidator: emailValidator)
        return sut
    }
    
    public func makeSignUpViewModel(name: String? = "any_name",
                               email: String? = "any_email",
                               password: String? = "any_password",
                               passwordConfirmation: String? = "any_password") -> SignUpViewModel {
        
        return SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
        
    }
}
