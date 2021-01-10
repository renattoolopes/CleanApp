//
//  SignUpViewModel.swift
//  Presentation
//
//  Created by Renato Lopes on 28/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation
import Domain

public struct SignUpViewModel: Model {
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
    
    // MARK: - Public Methods
    public func createAddAccountModel() throws -> AddAccountModel {
        guard let name: String = name,
              let email: String = email,
              let password: String = password,
              let passwordConfirmation: String = passwordConfirmation else {
            throw ModelError.failedConvertToModel
        }
        return AddAccountModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
    }
    
}
