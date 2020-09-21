//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Renato Lopes on 20/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import XCTest

class SignUpPresentationTests: XCTestCase {
    func test_signup_should_error_message_if_name_is_not_provided() {
        let viewModel: SignUpViewModel = SignUpViewModel(email: "renato", password: "123", passwordConfirmation: "123")
        let (sut, alertViewSpy) = makeSut()
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Nome é obrigatorio"))
    }
    
    func test_signup_should_error_message_if_email_is_not_provided() {
        let viewModel: SignUpViewModel = SignUpViewModel(name: "renato", password: "123", passwordConfirmation: "123")
        let (sut, alertViewSpy) = makeSut()
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Email é obrigatorio"))
    }
    
    func test_signup_should_error_message_if_password_is_not_provided() {
        let viewModel: SignUpViewModel = SignUpViewModel(name: "renato", email: "renattoolopes@gmail.com", passwordConfirmation: "123")
        let (sut, alertViewSpy) = makeSut()
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Senha é obrigatorio"))
    }
    
    func test_signup_should_error_message_if_password_confirmation_is_not_provided() {
        let viewModel: SignUpViewModel = SignUpViewModel(name: "renato", email: "renattoolopes@gmail.com", password: "123")
        let (sut, alertViewSpy) = makeSut()
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Confirmar Senha é obrigatorio"))
    }}

// Presenter

class SignUpPresenter {
    private var alertView: AlertView
    
    init(alertView: AlertView) {
        self.alertView = alertView
    }
    
    func signUp(viewModel: SignUpViewModel) {
        guard let nameField: String = validate(viewModel) else { return }
        alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação",
                                                        message: "O campo \(nameField) é obrigatorio")
        )
    }
    
    func validate(_ viewModel: SignUpViewModel) -> String? {
        if viewModel.name == nil || viewModel.name?.isEmpty ?? false  {
            return "Nome"
        } else if viewModel.email == nil || viewModel.email?.isEmpty ?? false {
            return "Email"
        } else if viewModel.password == nil || viewModel.password?.isEmpty ?? false {
            return "Senha"
        } else if viewModel.passwordConfirmation == nil || viewModel.passwordConfirmation?.isEmpty ?? false  {
            return "Confirmar Senha"
        }
        return nil
    }
}

// ViewModel
struct SignUpViewModel {
    var name: String?
    var email: String?
    var password: String?
    var passwordConfirmation: String?
}

struct AlertViewModel: Equatable {
    var title: String
    var message: String
}

// Protocol
protocol AlertView {
    func showMessage(viewModel: AlertViewModel)
}

// Spy
extension SignUpPresentationTests {
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
    
    func makeSut() -> (sut: SignUpPresenter, alertViewSpy: AlertViewSpy) {
        let alertViewSpy: AlertViewSpy = AlertViewSpy()
        let sut: SignUpPresenter = SignUpPresenter(alertView: alertViewSpy)
        return (sut, alertViewSpy)
    }
}
