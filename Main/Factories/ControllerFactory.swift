//
//  ControllerFactory.swift
//  Main
//
//  Created by Renato Lopes on 30/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation
import Domain
import UI
import Presentation
import Validation

final class ControllerFactory {
    public static func makeSignUpController(addAccount: AddAccount) -> SignUpViewController {
        let controller: SignUpViewController = try! SignUpViewController.instantiate()
        let emailValidator: EmailValidatorAdapter = EmailValidatorAdapter()
        let presenter: SignUpPresenter =  SignUpPresenter(alertView: controller, emailValidator: emailValidator , addAccount: addAccount, loadingView: controller)
        controller.signUp = presenter.signUp
        return controller
    }
}
