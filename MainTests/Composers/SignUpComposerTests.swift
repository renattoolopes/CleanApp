//
//  SignUpComposerTests.swift
//  MainTests
//
//  Created by Renato Lopes on 06/10/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import XCTest
import Main
import UI

class SignUpComposerTests: XCTestCase {
    func test_background_request_should_complete_on_main_thread() {
        let (sut, _) = makeSut()
        sut.loadViewIfNeeded()
    }
}

extension SignUpComposerTests {
    private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: SignUpViewController, addAccount: AddAccountSpy) {
        let addAccountSpy: AddAccountSpy = AddAccountSpy()
        let sut = SignUpComposer.composeController(withAddAccount: addAccountSpy)
        checkMemoryLeak(for: sut, inFile: file, andLine: line)
        checkMemoryLeak(for: addAccountSpy, inFile: file, andLine: line)
        return (sut, addAccountSpy)
    }
}
