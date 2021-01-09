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
    private var addAccount: AddAccount
    private var loadingView: LoadingView
    private var validation: Validation
    
    // MARK: - Initializers
    public init(alertView: AlertView,
                addAccount: AddAccount,
                loadingView: LoadingView,
                validation: Validation) {
        self.alertView = alertView
        self.addAccount = addAccount
        self.loadingView = loadingView
        self.validation = validation
    }
    
    // MARK: - Public Methods
    public func signUp(viewModel: SignUpViewModel) {
        if let message: String = validation.validate(data: viewModel.convertToJson()) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação",
                                                            message: message))
            
        } else {
            loadingView.display(viewModel: LoadingViewModel(isLoading: true))
            do {
                let addAccountModel: AddAccountModel = try SignUpMapper.createAddAccountModel(viewModel: viewModel)
            self.addAccount.add(account: addAccountModel) {[weak self] result in
                guard let self = self else { return }
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
                switch result {
                case .failure:
                    let alertViewModel: AlertViewModel = AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes")
                    self.alertView.showMessage(viewModel: alertViewModel)
                case .success:
                    let alertViewModel: AlertViewModel = AlertViewModel(title: "Sucesso", message: "Conta criada com sucesso!")
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
}
