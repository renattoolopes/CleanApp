//
//  AuthenticationSpy.swift
//  PresentationTests
//
//  Created by Renato Lopes on 17/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import Foundation
import Domain

public class AuthenticationSpy: Authentication {
    public var authModel: AuthenticationModel?
    public var completion: Authentication.AuthenticationResult?
    
    public func auth(with model: AuthenticationModel, completion: @escaping AuthenticationResult) {
        authModel = model
        self.completion = completion
    }
    
    public func completionWithError(_ error: DomainError) {
        completion?(.failure(error))
    }
    
    public func ocmpletionWithSuccess(_ account: AccountModel) {
        completion?(.success(account))
    }
    
    public init() { }
}
