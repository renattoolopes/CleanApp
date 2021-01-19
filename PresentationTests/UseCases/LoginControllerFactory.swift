//
//  LoginControllerFactory.swift
//  Main
//
//  Created by Renato Lopes on 17/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import Foundation
import Domain
import UI
import Domain
import UI
import Presentation
import Validation

public final class LoginControllerFactory {
    public static func composeController() -> LoginViewController {
        let controller: LoginViewController = try! LoginViewController.instantiate()
        let proxy: WeakVarProxy = WeakVarProxy(controller)
        let presenter: LoginPresenter = LoginPresenter(alertView: proxy, authentication: makeRemoteAuthenticationFactory(), loadingView: proxy, validation: ValidationComposite(validations: makeLoginValidations()))
            
        controller.loginEvent = presenter.login
        return controller
    }
    
    public static func composeController(withAuth authentication: Authentication) -> LoginViewController {
        let controller: LoginViewController = try! LoginViewController.instantiate()
        let proxy: WeakVarProxy = WeakVarProxy(controller)
        let presenter: LoginPresenter = LoginPresenter(alertView: proxy, authentication: authentication, loadingView: proxy, validation: ValidationComposite(validations: makeLoginValidations()))
            
        controller.loginEvent = presenter.login
        return controller
    }
}

