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
        let viewModel: SignUpViewModel = SignUpViewModel(name: nil, email: "renato", password: "123", passwordConfirmation: "123")
        let (sut, alertViewSpy) = makeSut()
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Nome é obrigatorio"))
    }
    
    func test_signup_should_error_message_if_email_is_not_provided() {
        let viewModel: SignUpViewModel = SignUpViewModel(name: "renato", email: nil, password: "123", passwordConfirmation: "123")
        let (sut, alertViewSpy) = makeSut()
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Email é obrigatorio"))
    }
    
    func test_signup_should_error_message_if_password_is_not_provided() {
        let viewModel: SignUpViewModel = SignUpViewModel(name: "renato", email: "renattoolopes@gmail.com", password: nil, passwordConfirmation: "123")
        let (sut, alertViewSpy) = makeSut()
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Senha é obrigatorio"))
    }
    
    func test_signup_should_error_message_if_password_confirmation_is_not_provided() {
        let viewModel: SignUpViewModel = SignUpViewModel(name: "renato", email: "renattoolopes@gmail.com", password: "123", passwordConfirmation: nil)
        let (sut, alertViewSpy) = makeSut()
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Confirmar senha é obrigatorio"))
    }

    func test_signup_should_error_message_if_password_confirmation_is_not_match() {
        let viewModel: SignUpViewModel = SignUpViewModel(name: "renato", email: "renattoolopes@gmail.com", password: "123", passwordConfirmation: "000")
        let (sut, alertViewSpy) = makeSut()
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "Falha ao Confirmar senha"))
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
    
    // MARK: - Public Methods
    public func makeSut() -> (sut: SignUpPresenter, alertViewSpy: AlertViewSpy) {
        let alertViewSpy: AlertViewSpy = AlertViewSpy()
        let sut: SignUpPresenter = SignUpPresenter(alertView: alertViewSpy)
        return (sut, alertViewSpy)
    }
}
