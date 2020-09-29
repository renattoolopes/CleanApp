//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by Renato Lopes on 21/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation
import Domain

public final class SignUpPresenter {
    // MARK: - Private Properties
    private var alertView: AlertView
    private var emailValidator: EmailValidator
    private var addAccount: AddAccount
    private var loadingView: LoadingView
    
    // MARK: - Initializers
    public init(alertView: AlertView,
                emailValidator: EmailValidator,
                addAccount: AddAccount,
                loadingView: LoadingView) {
        self.alertView = alertView
        self.emailValidator = emailValidator
        self.addAccount = addAccount
        self.loadingView = loadingView
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
            return "O campo Confirmar senha é inválido"
        } else if let email: String = viewModel.email, !emailValidator.isValid(email: email) {
            return "O campo Email é inválido"
        }
        return nil
    }
    
    // MARK: - Public Methods
    public func signUp(viewModel: SignUpViewModel) {
        if let message: String = validate(viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação",
                                                            message: message))
            
        } else {
            loadingView.display(viewModel: LoadingViewModel(isLoading: true))
            do {
            let addAccountModel: AddAccountModel = try createAddAccountModel(viewModel: viewModel)
            self.addAccount.add(account: addAccountModel) {[weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure:
                    let alertViewModel: AlertViewModel = AlertViewModel(title: "Error", message: "Algo inesperado aconteceu, tente novamente em alguns instantes")
                    self.alertView.showMessage(viewModel: alertViewModel)
                case .success:
                    break
                }
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
            }

            } catch {
                guard error is ModelError else { return }
                let alertModel: AlertViewModel = AlertViewModel(title: "Falha ao adicionar", message: "Não foi possível obter as inforções da conta. Entre em contato com um administrador.")
                alertView.showMessage(viewModel: alertModel)
            }
        }
    }
    
    // MARK: - Private Methods
    private func createAddAccountModel(viewModel: SignUpViewModel) throws -> AddAccountModel {
        guard let name: String = viewModel.name,
            let email: String = viewModel.email,
            let password: String = viewModel.password,
            let passwordConfirmation: String = viewModel.passwordConfirmation else {
                throw ModelError.failedConvertToModel
        }
        return AddAccountModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
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
