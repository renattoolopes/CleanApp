//
//  Authentication.swift
//  Domain
//
//  Created by Renato Lopes on 13/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import Foundation

public protocol Authentication {
    // MARK: - Type Values
    typealias AuthenticationResult = (Result<AccountModel, DomainError>) -> Void
    
    // MARK: - Methods
    func auth(with model: AuthenticationModel, completion: @escaping AuthenticationResult)
}

public struct AuthenticationModel: Model {
    // MARK: - Public Properties
    public var email: String
    public var password: String
    
    // MARK: - Initializers
    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
