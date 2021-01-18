//
//  LoginControllerFactoryTests.swift
//  MainTests
//
//  Created by Renato Lopes on 17/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import XCTest
import Validation
import Main
import UI

class LoginControllerFactoryTests: XCTestCase {

    func test_login_compose_with_correct_validations() {
        let validations = makeLoginValidations()
        
        XCTAssertEqual(validations[0] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"))
        
        XCTAssertEqual(validations[1] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha"))
        
        XCTAssertEqual(validations[2] as! EmailValidation, EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorSpy()))
    }
    
    func test_background_request_should_complete_on_main_thread() {
        let (sut, spy) = makeSut()
        sut.loadViewIfNeeded()
        let promise: XCTestExpectation = expectation(description: "Waiting")
        sut.loginEvent?(makeLoginViewModel())
        DispatchQueue.global().async {
            spy.completionWithError(.unexpected)
            promise.fulfill()
        }
        wait(for: [promise], timeout: 1.0)
    }

}


extension LoginControllerFactoryTests {
    func makeSut() -> (sut: LoginViewController, spy: AuthenticationSpy) {
        let spy = AuthenticationSpy()
        let sut = LoginControllerFactory.composeController(withAuth: MainQueueDispatchDecorator(spy))
        checkMemoryLeak(for: spy)
        checkMemoryLeak(for: sut)
        return (sut, spy)
    }
}
