//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by Renato Lopes on 21/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation

public final class SignUpPresenter {
    // MARK: - Private Properties
    private var alertView: AlertView
    private var emailValidator: EmailValidator
    
    // MARK: - Initializers
    public init(alertView: AlertView, emailValidator: EmailValidator) {
        self.alertView = alertView
        self.emailValidator = emailValidator
    }
    
    // MARK: - Private Methods
    private func validate(_ viewModel: SignUpViewModel) -> String? {
        if viewModel.name == nil || viewModel.name?.isEmpty ?? false  {
            return "O campo Nome é obrigatorio"
        } else if viewModel.email == nil || viewModel.email?.isEmpty ?? false {
            return "O campo Email é obrigatorio"
        } else if viewModel.password == nil || viewModel.password?.isEmpty ?? false {
            return "O campo Senha é obrigatorio"
        } else if viewModel.passwordConfirmation == nil || viewModel.passwordConfirmation?.isEmpty ?? false  {
            return "O campo Confirmar senha é obrigatorio"
        } else if viewModel.password != viewModel.passwordConfirmation {
            return "Falha ao Confirmar senha"
        }
        return nil
    }
    
    // MARK: - Public Methods
    public func signUp(viewModel: SignUpViewModel) {
        guard let message: String = validate(viewModel) else { return }
        alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação",
                                                        message: message))
        guard let email: String = viewModel.email else { return }
        let _ = emailValidator.isValid(email: email)

    }
}

// MARK: - View Models
public struct SignUpViewModel {
    // MARK: Public Properties
    public var name: String?
    public var email: String?
    public var password: String?
    public  var passwordConfirmation: String?
    
    // MARK: - Initializers
    public init(name: String?,
                email: String?,
                password: String?,
                passwordConfirmation: String?) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
}
