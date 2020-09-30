//
//  EmailValidatorAdapterTests.swift
//  ValidationTests
//
//  Created by Renato Lopes on 30/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import XCTest
import Presentation

class EmailValidatorAdapterTests: XCTestCase {
    func test_invalid_emails() {
        let sut = EmailValidatorAdapter()
        XCTAssertFalse(sut.isValid(email: ""))
        XCTAssertFalse(sut.isValid(email: "rr"))
        XCTAssertFalse(sut.isValid(email: "rr@"))
        XCTAssertFalse(sut.isValid(email: "rr@rr"))
        XCTAssertFalse(sut.isValid(email: "rr@rr."))
        XCTAssertFalse(sut.isValid(email: "@rr.com"))
    }
}


public final class EmailValidatorAdapter: EmailValidator {
    private let pattern: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    public func isValid(email: String) -> Bool {
        let range = NSRange(location: 0, length: email.utf8.count)
        let regex = try? NSRegularExpression(pattern: pattern)
        return regex?.firstMatch(in: email, range: range) != nil
    }
}
