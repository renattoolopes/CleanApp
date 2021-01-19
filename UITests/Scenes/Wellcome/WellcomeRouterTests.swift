//
//  WellcomeRouterTests.swift
//  UITests
//
//  Created by Renato Lopes on 18/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import XCTest
import UIKit
import UI

class WellcomeRouterTests: XCTestCase {
    func test_go_to_login_calls_correct_controller() {
        let (sut, nav) = makeSut()
        sut.gotoLogin()
        XCTAssertEqual(1, nav.viewControllers.count)
        XCTAssertTrue(nav.viewControllers[0] is LoginViewController)

    }
    
    func test_go_to_signUp_calls_correct_controller() {
        let (sut, nav) = makeSut()
        sut.gotoSignUp()
        XCTAssertEqual(1, nav.viewControllers.count)
        XCTAssertTrue(nav.viewControllers[0] is SignUpViewController)
    }
}


extension WellcomeRouterTests {
    func makeSut() -> (sut: WellcomeRouter, nav: NavigationController) {
        let nav = NavigationController()
        let sut = WellcomeRouter(nav: nav,
                                 loginFactory: { try! LoginViewController.instantiate() },
                                 signUpFactory: { try! SignUpViewController.instantiate() })
        checkMemoryLeak(for: nav)
        checkMemoryLeak(for: sut)
        return (sut, nav)
    }
}
