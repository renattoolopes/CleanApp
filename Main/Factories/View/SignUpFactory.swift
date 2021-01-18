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

public final class SingUpFactory {
    public static func composeController(withAddAccount addAccount: AddAccount) -> SignUpViewController {
        let controller: SignUpViewController = try! SignUpViewController.instantiate()
        let proxy: WeakVarProxy = WeakVarProxy(controller)
        let presenter: SignUpPresenter =  SignUpPresenter(alertView: proxy, addAccount: addAccount, loadingView: proxy, validation: ValidationComposite(validations: makeSignUpValidations()))
        controller.signUp = presenter.signUp
        return controller
    }
    

}
