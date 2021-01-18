//
//  EmailValidation.swift
//  Validation
//
//  Created by Renato Lopes on 09/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import Foundation
import Presentation

public class EmailValidation: Validation {
    // MARK: - Private Properties
    private let fieldName: String
    private let fieldLabel: String
    private let emailValidator: EmailValidator

    // MARK: - Inits
    public init(fieldName: String, fieldLabel: String, emailValidator: EmailValidator) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
        self.emailValidator = emailValidator
    }
    
    // MARK: - Public Methods
    public func validate(data: [String : Any]?) -> String? {
        
        guard let email: String = data?[fieldName] as? String, emailValidator.isValid(email: email) else {
            return "O campo \(fieldLabel) é inválido"
        }
        return nil
    }
}

extension EmailValidation: Equatable {
    public static func == (lhs: EmailValidation, rhs: EmailValidation) -> Bool {
        return lhs.fieldName == rhs.fieldName && lhs.fieldLabel == rhs.fieldLabel
    }
    
}
