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

public final class SignUpComposer {
    public static func composeController(withAddAccount addAccount: AddAccount) -> SignUpViewController {
        let controller: SignUpViewController = try! SignUpViewController.instantiate()
        let proxy: WeakVarProxy = WeakVarProxy(controller)
        let presenter: SignUpPresenter =  SignUpPresenter(alertView: proxy, addAccount: addAccount, loadingView: proxy, validation: makeValidations())
        controller.signUp = presenter.signUp
        return controller
    }
    
    private static func makeValidations() -> Validation {
        let requiredName: RequiredFieldValidation = RequiredFieldValidation(fieldName: "name", fieldLabel: "Name")
        let requiredEmail: RequiredFieldValidation = RequiredFieldValidation(fieldName: "email", fieldLabel: "Email")
        let requiredPassword: RequiredFieldValidation = RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha")
        let requiredPasswordConfirmation: RequiredFieldValidation = RequiredFieldValidation(fieldName: "passwordConfirmation", fieldLabel: "Confirmar senha")
        let comparePasswords: CompareFieldsValidation = CompareFieldsValidation(firstField: "password", secondField: "passwordConfirmation", fieldLabel: "Senha")
        
        
        return ValidationComposite(validations: [
            requiredName,
            requiredEmail,
            requiredPassword,
            requiredPasswordConfirmation,
            comparePasswords
        ])
    }
}
