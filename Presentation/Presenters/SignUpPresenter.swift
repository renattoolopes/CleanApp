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
    
    // MARK: - Initializers
    public init(alertView: AlertView) {
        self.alertView = alertView
    }
    
    // MARK: - Private Methods
    private func validate(_ viewModel: SignUpViewModel) -> String? {
        if viewModel.name == nil || viewModel.name?.isEmpty ?? false  {
            return "Nome"
        } else if viewModel.email == nil || viewModel.email?.isEmpty ?? false {
            return "Email"
        } else if viewModel.password == nil || viewModel.password?.isEmpty ?? false {
            return "Senha"
        } else if viewModel.passwordConfirmation == nil || viewModel.passwordConfirmation?.isEmpty ?? false  {
            return "Confirmar Senha"
        }
        return nil
    }
    
    // MARK: - Public Methods
    public func signUp(viewModel: SignUpViewModel) {
        guard let nameField: String = validate(viewModel) else { return }
        alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação",
                                                        message: "O campo \(nameField) é obrigatorio")
        )
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
