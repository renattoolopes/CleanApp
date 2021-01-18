//
//  LoginPresenter.swift
//  Presentation
//
//  Created by Renato Lopes on 17/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import Foundation
import Domain

public final class LoginPresenter {
    // MARK: - Private Properties
    private var alertView: AlertView
    private var authentication: Authentication
    private var loadingView: LoadingView
    private var validation: Validation
    
    // MARK: - Initializers
    public init(alertView: AlertView,
                authentication: Authentication,
                loadingView: LoadingView,
                validation: Validation) {
        self.alertView = alertView
        self.authentication = authentication
        self.loadingView = loadingView
        self.validation = validation
    }
    
    // MARK: - Public Methods
    public func login(viewModel: LoginRequest) {
        if let message: String = validation.validate(data: viewModel.convertToJson()) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação",
                                                            message: message))
            
        } else {
            loadingView.display(viewModel: LoadingViewModel(isLoading: true))
            do {
                let authenticationModel: AuthenticationModel = try viewModel.createAuthenticationModel()
                
                self.authentication.auth(with: authenticationModel) {[weak self] result in
                guard let self = self else { return }
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
                switch result {
                
                case .success:
                    let alertViewModel: AlertViewModel = AlertViewModel(title: "Sucesso", message: "Login feito com sucesso.")
                    self.alertView.showMessage(viewModel: alertViewModel)
                    
                case .failure(let error):
                    let errorMessage: String = self.makeMessageDomainError(error)
                    let alertViewModel: AlertViewModel = AlertViewModel(title: "Erro", message: errorMessage)
                    self.alertView.showMessage(viewModel: alertViewModel)
                }
                
            }

            } catch {
                guard error is ModelError else { return }
                let alertModel: AlertViewModel = AlertViewModel(title: "Falha ao adicionar", message: "Não foi possível obter as inforções da conta. Entre em contato com um administrador.")
                alertView.showMessage(viewModel: alertModel)
            }
        }
    }
    
    private func makeMessageDomainError(_ error: DomainError) -> String {
        switch error {
        case .unexpected:
            return "Algo inesperado aconteceu, tente novamente em alguns instantes"
        case .expiredSession:
            return "Email e/ou senha inválido(s)."
        default:
            return "Algo inesperado aconteceu, tente novamente em alguns instantes"
        }
    }
}
