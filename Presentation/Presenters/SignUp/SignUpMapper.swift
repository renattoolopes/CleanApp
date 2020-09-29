//
//  SignUpMapper.swift
//  Presentation
//
//  Created by Renato Lopes on 28/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation
import Domain

public final class SignUpMapper {
    // MARK: - Private Methods
    static func createAddAccountModel(viewModel: SignUpViewModel) throws -> AddAccountModel {
        guard let name: String = viewModel.name,
            let email: String = viewModel.email,
            let password: String = viewModel.password,
            let passwordConfirmation: String = viewModel.passwordConfirmation else {
                throw ModelError.failedConvertToModel
        }
        return AddAccountModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
    }
}
