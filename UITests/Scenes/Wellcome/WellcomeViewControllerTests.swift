//
//  WellcomeViewControllerTests.swift
//  UITests
//
//  Created by Renato Lopes on 18/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import XCTest
import UIKit
@testable import UI

class WellcomeViewControllerTests: XCTestCase {
    
    func test_loginButton_calls_login_on_tap() {
        let (sut, spy) = makeSut()
        sut.loginButton?.simulateTap()
        XCTAssertEqual(1, spy.clicks)
    }
    
    func test_signUpButton_calls_login_on_tap() {
        let (sut, spy) = makeSut()
        sut.signUpButton?.simulateTap()
        XCTAssertEqual(1, spy.clicks)
    }
    
}

extension WellcomeViewControllerTests {
    func makeSut() -> (sut: WellcomeViewController, spy: ButtonSpy) {
        let buttonSpy = ButtonSpy()
        let sut = try! WellcomeViewController.instantiate()
        sut.loadViewIfNeeded()
        checkMemoryLeak(for: sut)
        
        sut.loginEvent = buttonSpy.onClick
        sut.signUpEvent = buttonSpy.onClick
        return (sut, buttonSpy)
    }
    class ButtonSpy {
        var clicks: Int = 0
        
        func onClick() {
            clicks += 1
        }
    }
}
