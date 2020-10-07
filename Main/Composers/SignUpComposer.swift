//
//  SignUpComposer.swift
//  Main
//
//  Created by Renato Lopes on 06/10/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation
import Domain
import UI
import Domain
import UI
import Presentation
import Validation

public final class SignUpComposer {
    public static func composeController(withAddAccount addAccount: AddAccount) -> SignUpViewController {
        let controller: SignUpViewController = try! SignUpViewController.instantiate()
        let emailValidator: EmailValidatorAdapter = EmailValidatorAdapter()
        let proxy: WeakVarProxy = WeakVarProxy(controller)
        let presenter: SignUpPresenter =  SignUpPresenter(alertView: proxy, emailValidator: emailValidator , addAccount: addAccount, loadingView: proxy)
        controller.signUp = presenter.signUp
        return controller
    }
}
