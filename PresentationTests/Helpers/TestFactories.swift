//
//  TestFactories.swift
//  PresentationTests
//
//  Created by Renato Lopes on 29/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation
import Presentation

public func makeSignUpViewModel(name: String? = "any_name",
                                email: String? = "any_email",
                                password: String? = "any_password",
                                passwordConfirmation: String? = "any_password") -> SignUpViewModel {
    
    return SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
    
}

public func makeRequiredAlertViewModel(withField: String) -> AlertViewModel {
    return AlertViewModel(title: "Falha na validação",
                          message: "O campo \(withField) é obrigatorio")
}

public func makeInvalidAlertViewModel(withField: String) -> AlertViewModel {
    return AlertViewModel(title: "Falha na validação",
                          message: "O campo \(withField) é inválido")
}

public func makeAlertViewModel(withError: Bool = false, withMessage message: String) -> AlertViewModel {
    if withError {
        return AlertViewModel(title: "Erro", message: message)
    } else {
        return AlertViewModel(title: "Sucesso", message: message)
    }
}
