//
//  EmailValidatorAdapterTests.swift
//  ValidationTests
//
//  Created by Renato Lopes on 30/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import XCTest
import Infra

class EmailValidatorAdapterTests: XCTestCase {
    func test_invalid_emails() {
        let sut: EmailValidatorAdapter = makeSut()
        XCTAssertFalse(sut.isValid(email: ""))
        XCTAssertFalse(sut.isValid(email: "rr"))
        XCTAssertFalse(sut.isValid(email: "rr@"))
        XCTAssertFalse(sut.isValid(email: "rr@rr"))
        XCTAssertFalse(sut.isValid(email: "rr@rr."))
        XCTAssertFalse(sut.isValid(email: "@rr.com"))
    }
    
    func test_valid_emails() {
        let sut: EmailValidatorAdapter = makeSut()
        XCTAssertTrue(sut.isValid(email: "renato@gmail.com"))
        XCTAssertTrue(sut.isValid(email: "renato@hotmail.com"))
        XCTAssertTrue(sut.isValid(email: "renato@outlook.com"))
        XCTAssertTrue(sut.isValid(email: "renato@hotmail.com"))
        XCTAssertTrue(sut.isValid(email: "renato@testing.com"))
    }
}


extension EmailValidatorAdapterTests {
    func makeSut() -> EmailValidatorAdapter {
        return EmailValidatorAdapter()
    }
}
