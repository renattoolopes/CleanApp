//
//  SignUpFactory.swift
//  Main
//
//  Created by Renato Lopes on 30/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation
import UI
import Presentation
import Validation
import Data
import Infra

class SignUpFactory {
    public static func makeController() -> SignUpViewController {
        let controller: SignUpViewController = try! SignUpViewController.instantiate()
        let emailValidator: EmailValidatorAdapter = EmailValidatorAdapter()
        let service: AlamofireAdapter = AlamofireAdapter()
        let url: URL = URL(string: "https://clean-node-api.herokuapp.com/api/signup")!
        let addAccountUseCase: RemoteAddAccount = RemoteAddAccount(url: url, httpPostClient: service)
        let presenter =  SignUpPresenter(alertView: controller, emailValidator: emailValidator , addAccount: addAccountUseCase, loadingView: controller)
        controller.signUp = presenter.signUp
        return controller
    }
}
