//
//  LoginViewControllerTests.swift
//  UITests
//
//  Created by Renato Lopes on 17/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import XCTest
import Presentation
import UIKit
@testable import UI

class LoginViewControllerTests: XCTestCase {
    
    func test_loading_is_hidden_on_start() {
        let sut: LoginViewController = makeSut()
        XCTAssertEqual(sut.loadingIndicator?.isAnimating, false)
    }
    
    func test_sut_implements_loadingView() {
        let sut: LoginViewController = makeSut()
        XCTAssertNotNil(sut as LoadingView)
    }
    
    func test_sut_implements_alertView() {
        let sut: LoginViewController = makeSut()
        XCTAssertNotNil(sut as AlertView)
    }
    
    func test_loginButton_calls_login_on_tap() {
        var loginViewModel: LoginViewModel?
        
        let loginSpy: (LoginViewModel) -> Void = { viewModel in
            loginViewModel = viewModel
        }
        
        let sut: LoginViewController = makeSut(loginSpy: loginSpy)
        sut.loginButton?.simulateTap()
        let email: String? = sut.emailTextField?.text
        let password: String? = sut.passwordTextField?.text

        XCTAssertEqual(loginViewModel, LoginViewModel(email: email, password: password))
    }
}

extension LoginViewControllerTests {
    func makeSut(loginSpy: ((LoginViewModel) -> Void)? = nil) -> LoginViewController {
        let sut = try! LoginViewController.instantiate()
        sut.loginEvent = loginSpy
        sut.loadViewIfNeeded()
        checkMemoryLeak(for: sut)
        return sut
    }
}
