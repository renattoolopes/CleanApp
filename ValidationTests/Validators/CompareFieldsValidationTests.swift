//
//  CompareFieldsValidationTests.swift
//  ValidationTests
//
//  Created by Renato Lopes on 09/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import XCTest
import Validation
import Presentation

class CompareFieldsValidationTests: XCTestCase {

    func test_validation_should_return_error_if_comparation_fails() {
        let sut: Validation = makeSut(fieldName: "password", compareTo: "passwordConfirmation", withFieldLabel: "Senha")
        let error: String? = sut.validate(data: ["password" : "123", "passwordConfirmation" : "1234"])
        XCTAssertEqual(error, "O campo Senha é inválido")
    }
    
    func test_validate_should_return_error_if_with_correct_fieldLabel() {
        let sut: Validation = makeSut(fieldName: "password", compareTo: "passwordConfirmation", withFieldLabel: "Confirmar Senha")
        let error: String? = sut.validate(data: ["password" : "123", "passwordConfirmation" : "1234"])
        XCTAssertEqual(error, "O campo Confirmar Senha é inválido")
    }
    
    func test_validate_should_return_error_if_comparation_success() {
        let sut: Validation = makeSut(fieldName: "password", compareTo: "passwordConfirmation", withFieldLabel: "Confirmar Senha")
        let error: String? = sut.validate(data: ["password" : "123", "passwordConfirmation" : "123"])
        XCTAssertNil(error)
    }
    
    
    func test_validate_should_return_error_if_no_data_is_provided() {
        let sut: Validation = makeSut(fieldName: "password", compareTo: "passwordConfirmation", withFieldLabel: "Confirmar Senha")
        let error: String? = sut.validate(data: nil)
        XCTAssertEqual(error, "O campo Confirmar Senha é inválido")
    }
    
}

extension CompareFieldsValidationTests {
    func makeSut(fieldName: String, compareTo: String, withFieldLabel: String) -> Validation {
        let compareValidation: CompareFieldsValidation = CompareFieldsValidation(firstField: fieldName, secondField: compareTo, fieldLabel: withFieldLabel)
        checkMemoryLeak(for: compareValidation)
        return compareValidation
    }
}
