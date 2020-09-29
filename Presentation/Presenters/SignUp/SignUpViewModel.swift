//
//  SignUpViewModel.swift
//  Presentation
//
//  Created by Renato Lopes on 28/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation

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
