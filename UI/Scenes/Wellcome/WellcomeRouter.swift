//
//  WellcomeRouter.swift
//  UI
//
//  Created by Renato Lopes on 18/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import Foundation

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
