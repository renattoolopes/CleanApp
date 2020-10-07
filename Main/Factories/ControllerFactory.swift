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
        let proxy: WeakVarProxy = WeakVarProxy(controller)
        let presenter: SignUpPresenter =  SignUpPresenter(alertView: proxy, emailValidator: emailValidator , addAccount: addAccount, loadingView: proxy)
        controller.signUp = presenter.signUp
        return controller
    }
}

class WeakVarProxy<T: AnyObject> {
    // MARK: - Private Properties
    private weak var instance: T?
    
    // MARK: - Initializers
    init(_ instance: T) {
        self.instance = instance
    }
}

// MARK: - WeakVarProxy Extension
extension WeakVarProxy: AlertView where T: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        instance?.showMessage(viewModel: viewModel)
    }
}

extension WeakVarProxy: LoadingView where T: LoadingView {
    func display(viewModel: LoadingViewModel) {
        instance?.display(viewModel: viewModel)
    }
}
