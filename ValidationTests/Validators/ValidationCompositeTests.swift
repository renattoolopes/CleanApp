//
//  ValidationCompositeTests.swift
//  ValidationTests
//
//  Created by Renato Lopes on 09/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import XCTest
import Validation
import Presentation

class ValidationCompositeTests: XCTestCase {

    func test_validate_should_return_error_if_validation_fails() {
        let spy: ValidationSpy = ValidationSpy()
        let sut: Validation = makeSut(validations: [spy])
        spy.simulateError("Error Spy")
        let errorMessage: String? = sut.validate(data: ["email" : "validEmail@gmail.com"])
        XCTAssertEqual(errorMessage, "Error Spy")
    }
    
    func test_validate_should_return_nil_if_validation_successds() {
        let sut: Validation = makeSut()
        let errorMessage: String? = sut.validate(data: ["email" : "validEmail@gmail.com"])
        XCTAssertNil(errorMessage)
    }
    
    func test_validate_should_return_the_first_error_message() {
        let spy: ValidationSpy = ValidationSpy()
        let spy2: ValidationSpy = ValidationSpy()
        let sut: Validation = makeSut(validations: [spy, spy2])
        spy.simulateError("Error Spy 01")
        spy2.simulateError("Error Spy 02")
        let errorMessage: String? = sut.validate(data: ["email" : "validEmail@gmail.com"])
        XCTAssertEqual(errorMessage, "Error Spy 01")
    }

    func test_validate_should_return_correct_error_message() {
        let spy: ValidationSpy = ValidationSpy()
        let spy2: ValidationSpy = ValidationSpy()
        let sut: Validation = makeSut(validations: [spy, spy2])
        
        spy2.simulateError("Error Spy 03")
        let errorMessage: String? = sut.validate(data: ["email" : "validEmail@gmail.com"])
        XCTAssertEqual(errorMessage, "Error Spy 03")
    }
    
    func test_validate_should_call_validation_with_correct_data() {
        let spy: ValidationSpy = ValidationSpy()
        let sut: Validation = makeSut(validations: [spy])
        let data = ["email" : "validEmail@gmail.com"]
        
        _ = sut.validate(data: data)
        XCTAssertTrue(NSDictionary(dictionary: spy.data!).isEqual(to: data))
    }
}

extension ValidationCompositeTests {
    func makeSut(validations: [Validation] = [ValidationSpy()]) -> ValidationComposite{
        let composite: ValidationComposite = ValidationComposite(validations: validations)
        return composite
    }
}




