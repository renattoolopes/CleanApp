//
//  LoginViewModel.swift
//  Presentation
//
//  Created by Renato Lopes on 17/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import Foundation
import Domain

public struct LoginRequest: Model {
    // MARK: Public Properties
    public var email: String?
    public var password: String?
    
    // MARK: - Initializers
    public init(email: String?,
                password: String?) {
        self.email = email
        self.password = password
    }
    
    // MARK: - Public Methods
    public func createAuthenticationModel() throws -> AuthenticationModel {
        guard let email: String = email,
              let password: String = password else {
            throw ModelError.failedConvertToModel
        }
        return AuthenticationModel(email: email, password: password)
    }
    
}
