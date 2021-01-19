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
    
    public init(nav: NavigationController, loginFactory: @escaping () -> LoginViewController) {
        self.nav = nav
        self.loginFactory = loginFactory
    }
    
    public func gotoLogin() {
        let controller: LoginViewController = loginFactory()
        nav.push(viewController: controller)
    }
}

class WellcomeRouterTests: XCTestCase {
    func test_go_to_login_calls_correct_controller() {
        let nav = NavigationController()
        let sut = WellcomeRouter(nav: nav, loginFactory: { try! LoginViewController.instantiate() })
        sut.gotoLogin()
        XCTAssertEqual(1, nav.viewControllers.count)
        XCTAssertTrue(nav.viewControllers[0] is LoginViewController)
        checkMemoryLeak(for: nav)
        checkMemoryLeak(for: sut)
    }
}
