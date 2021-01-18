//
//  ValidationFactory.swift
//  Main
//
//  Created by Renato Lopes on 17/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import Foundation
import Validation
import Presentation
import Infra

public func makeSignUpValidations() -> [Validation] {
    let requiredName: RequiredFieldValidation = RequiredFieldValidation(fieldName: "name", fieldLabel: "Name")
    let requiredEmail: RequiredFieldValidation = RequiredFieldValidation(fieldName: "email", fieldLabel: "Email")
    let requiredPassword: RequiredFieldValidation = RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha")
    let requiredPasswordConfirmation: RequiredFieldValidation = RequiredFieldValidation(fieldName: "passwordConfirmation", fieldLabel: "Confirmar senha")
    let comparePasswords: CompareFieldsValidation = CompareFieldsValidation(firstField: "password", secondField: "passwordConfirmation", fieldLabel: "Senha")
    let emailValidation: EmailValidation = EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorAdapter())
    
    
    return [
        requiredName,
        requiredEmail,
        requiredPassword,
        requiredPasswordConfirmation,
        comparePasswords,
        emailValidation
    ]
}

public func makeLoginValidations() -> [Validation] {
    let emailRequired: RequiredFieldValidation = RequiredFieldValidation(fieldName: "email", fieldLabel: "Email")
    let passwordRequired: RequiredFieldValidation = RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha")
    let emailValidation: EmailValidation = EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorAdapter())
    
    return [emailRequired, passwordRequired, emailValidation]
}
