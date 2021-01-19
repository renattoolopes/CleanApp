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
    if let email: [Validation] =  ValidationBuilder.field("email")?.label("Email").required().email().build(),
       let password:  [Validation] = ValidationBuilder.field("password")?.label("Senha").required().build(),
       let name: [Validation] = ValidationBuilder.field("name")?.label("Nome").required().build(),
       let confirmationPassword:  [Validation] = ValidationBuilder.field("password")?.secondField("passwordConfirmation").label("Senha").compare().build() {
        return name + email + password + confirmationPassword // return array of validations
    }
    
    return []
}

public func makeLoginValidations() -> [Validation] {
    
    if let email =  ValidationBuilder.field("email")?.label("Email").required().email().build(),
       let password = ValidationBuilder.field("password")?.label("Senha").required().build() {
        return email + password // return array of validations
    }
    
    return []
}
