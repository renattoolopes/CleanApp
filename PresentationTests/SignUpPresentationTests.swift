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
        let alertViewSpy: AlertViewSpy = AlertViewSpy()
        let sut: SignUpPresenter = SignUpPresenter(alertView: alertViewSpy)
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Nome é obrigatorio"))
    }

}

// Presenter

class SignUpPresenter {
    private var alertView: AlertView
    
    init(alertView: AlertView) {
        self.alertView = alertView
    }
    
    func signUp(viewModel: SignUpViewModel) {
        guard viewModel.name == nil || !(viewModel.name?.isEmpty ?? false) else { return }
        alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação",
                                                        message: "O campo Nome é obrigatorio")
        )
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
}
