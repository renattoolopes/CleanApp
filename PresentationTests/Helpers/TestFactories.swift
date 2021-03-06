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
                                passwordConfirmation: String? = "any_password") -> SignUpRequest {
    
    return SignUpRequest(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
    
}

public func makeLoginViewModel(email: String? = "any_email",
                                password: String? = "any_password") -> LoginRequest {
    
    return LoginRequest(email: email, password: password)
    
}
