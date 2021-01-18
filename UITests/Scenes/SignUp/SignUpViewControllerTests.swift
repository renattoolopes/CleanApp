//
//  SignUpViewControllerTests.swift
//  UITests
//
//  Created by Renato Lopes on 29/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import XCTest
import Presentation
import UIKit
@testable import UI

class SignUpViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start() {
        let sut: SignUpViewController = makeSut()
        XCTAssertEqual(sut.loadingIndicator?.isAnimating, false)
    }
    
    func test_sut_implements_loadingView() {
        let sut: SignUpViewController = makeSut()
        XCTAssertNotNil(sut as LoadingView)
    }
    
    func test_sut_implements_alertView() {
        let sut: SignUpViewController = makeSut()
        XCTAssertNotNil(sut as AlertView)
    }
    
    func test_saveButton_calls_signUp_on_tap() {
        var signUpViewModel: SignUpRequest?
        
        let signUpSpy: (SignUpRequest) -> Void = { viewModel in
            signUpViewModel = viewModel
        }
        let sut: SignUpViewController = makeSut(signUpSpy: signUpSpy)
        sut.saveButton?.simulateTap()
        let name: String? = sut.nameTextField?.text
        let email: String? = sut.emailTextField?.text
        let password: String? = sut.passwordTextField?.text
        let passwordConfirmation: String? = sut.passwordConfirmationTextField?.text

        XCTAssertEqual(signUpViewModel, SignUpRequest(name: name,
                                                        email: email,
                                                        password: password,
                                                        passwordConfirmation: passwordConfirmation))
    }
}

extension SignUpViewControllerTests {
    func makeSut(signUpSpy: ((SignUpRequest) -> Void)? = nil) -> SignUpViewController {
        do {
            let sut: SignUpViewController = try SignUpViewController.instantiate()
            sut.signUp = signUpSpy
            sut.loadViewIfNeeded()
            return sut
        } catch {
            XCTFail("Failed to create storyboard with SignUpViewController")
        }
        return SignUpViewController()
    }
}
