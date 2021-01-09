//
//  EmailValidationTests.swift
//  ValidationTests
//
//  Created by Renato Lopes on 09/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import XCTest
import Validation
import Presentation

class EmailValidationTests: XCTestCase {
    func test_validation_should_return_error_if_invalid_email_is_provided() {
        let spy: EmailValidatorSpy = EmailValidatorSpy()
        let sut: EmailValidation = makeSut(fieldLabel: "Email", withValidator: spy)
        spy.simulatedInvalidEmail()
        let error: String? = sut.validate(data: ["email": "invalid_email@gmail.com"])
        XCTAssertEqual(error, "O campo Email é inválido")
    }
    
    func test_validation_should_return_error_with_correct_fieldLabel() {
        let spy: EmailValidatorSpy = EmailValidatorSpy()
        let sut: EmailValidation = makeSut(fieldLabel: "Email2", withValidator: spy)
        spy.simulatedInvalidEmail()
        let error: String? = sut.validate(data: ["email": "invalid_email@gmail.com"])
        XCTAssertEqual(error, "O campo Email2 é inválido")
    }
    
    func test_validation_should_return_nil_if_valid_email_is_provided() {
        let sut: EmailValidation = makeSut(fieldLabel: "Email")
        let error: String? = sut.validate(data: ["email": "valid_email@gmail.com"])
        XCTAssertNil(error)
    }
    
    func test_validation_should_return_error_if_data_is_not_provided() {
        let spy: EmailValidatorSpy = EmailValidatorSpy()
        let sut: EmailValidation = makeSut(fieldLabel: "Email", withValidator: spy)
        spy.simulatedInvalidEmail()
        let error: String? = sut.validate(data: nil)
        XCTAssertEqual(error, "O campo Email é inválido")
    }
}

extension EmailValidationTests {
    func makeSut(fieldLabel: String, withValidator: EmailValidator = EmailValidatorSpy()) -> EmailValidation {
        let validation: EmailValidation = EmailValidation(fieldName: "email", fieldLabel: fieldLabel, emailValidator: withValidator)
        checkMemoryLeak(for: validation)
        return validation

    }
}
