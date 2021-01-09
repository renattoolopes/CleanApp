//
//  SignUpIntegrationTests.swift
//  MainTests
//
//  Created by Renato Lopes on 06/10/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import XCTest
import Main

class SignUpIntegrationTests: XCTestCase {
    func test_ui_presentation_integration() {
        let sut = SignUpComposer.composeController(withAddAccount: AddAccountSpy())
        checkMemoryLeak(for: sut)
    }
}
