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


public final class WellcomeRouter {
    private let nav: NavigationController
    private let loginFactory: () -> LoginViewController
    private let signUpFactory: () -> SignUpViewController

    public init(nav: NavigationController,
                loginFactory: @escaping () -> LoginViewController,
                signUpFactory: @escaping () -> SignUpViewController) {
        self.nav = nav
        self.loginFactory = loginFactory
        self.signUpFactory = signUpFactory
    }
    
    public func gotoLogin() {
        let controller: LoginViewController = loginFactory()
        nav.push(viewController: controller)
    }
    
    public func gotoSignUp() {
        let controller: SignUpViewController = signUpFactory()
        nav.push(viewController: controller)
    }
}

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
