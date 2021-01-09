//
//  RequiredFieldValidationTests.swift
//  ValidationTests
//
//  Created by Renato Lopes on 09/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import XCTest
import Presentation
import Validation

class RequiredFieldValidationTests: XCTestCase {

    func test_validation_should_return_error_if_field_is_not_provided() {
        let sut: Validation = makeSut(fieldName: "email",  andLabel: "Email")
        let errorMessage: String? = sut.validate(data: ["name" : "Renato Lopes"])
        XCTAssertEqual(errorMessage, "O campo Email é obrigatório")
    }
    
    func test_validation_should_return_error_with_correct_fieldLabel() {
        let sut: Validation = makeSut(fieldName: "age",  andLabel: "Idade")
        let errorMessage: String? = sut.validate(data: ["name" : "Renato Lopes"])
        XCTAssertEqual(errorMessage, "O campo Idade é obrigatório")
    }


    func test_validation_should_return_nil_if_field_is_provided() {
        let sut: Validation = makeSut(fieldName: "email",  andLabel: "Email")
        let errorMessage: String? = sut.validate(data: ["email" : "renattoolopes@gmail.com"])
        XCTAssertNil(errorMessage)
    }
    
    func test_validation_should_return_nil_if_no_datais_provided() {
        let sut: Validation = makeSut(fieldName: "email",  andLabel: "Email")
        let errorMessage: String? = sut.validate(data: nil)
        XCTAssertEqual(errorMessage, "O campo Email é obrigatório")
    }
}

extension RequiredFieldValidationTests {
    func makeSut(fieldName: String, andLabel: String) -> Validation {
        let sut: RequiredFieldValidation = RequiredFieldValidation(fieldName: fieldName, fieldLabel: andLabel)
        checkMemoryLeak(for: sut)
        return sut
    }
}
