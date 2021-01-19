//
//  WellcomeControllerFactory.swift
//  Main
//
//  Created by Renato Lopes on 18/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import Foundation
import UI

public class WellcomeControllerFactory {
    public static func composeController(navigation: NavigationController) -> WellcomeViewController {
        let wellcomeController: WellcomeViewController = try! WellcomeViewController.instantiate()
        let router = WellcomeRouter(nav: navigation, loginFactory: LoginControllerFactory.composeController, signUpFactory: SingUpFactory.composeController)
        wellcomeController.loginEvent = router.gotoLogin
        wellcomeController.signUpEvent = router.gotoSignUp
        return wellcomeController
    }
}
