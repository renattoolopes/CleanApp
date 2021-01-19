//
//  ValidationBuilder.swift
//  Main
//
//  Created by Renato Lopes on 18/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import Foundation
import Presentation
import Validation
import Infra

public final class ValidationBuilder {
    private static var instance: ValidationBuilder?
    private var fieldName: String?
    private var secondFieldName: String?
    private var fieldLabel: String?
    private var validations: [Validation] = [Validation]()

    private init() { }
    
    // MARK: - All parameters
    public static func field(_ name: String) -> ValidationBuilder? {
        instance = ValidationBuilder()
        instance?.fieldName = name
        return instance
    }
    
    public func secondField(_ name: String) -> ValidationBuilder {
        secondFieldName = name
        return self
    }
    
    public func label(_ name: String) -> ValidationBuilder {
        fieldLabel = name
        return self
    }
    
    // MARK: - Validations
    
    public func required() -> ValidationBuilder {
        guard let field: String = fieldName, let label: String = fieldLabel else { return self }
        validations.append(RequiredFieldValidation(fieldName: field, fieldLabel: label))
        return self
    }
    
    public func email() -> ValidationBuilder {
        guard let field: String = fieldName, let label: String = fieldLabel else { return self }
        validations.append(EmailValidation(fieldName: field, fieldLabel: label, emailValidator: EmailValidatorAdapter()))
        return self
    }
    
    public func compare() -> ValidationBuilder {
        guard let field: String = fieldName, let secondField: String = secondFieldName, let label: String = fieldLabel else { return self }
        validations.append(CompareFieldsValidation(firstField: field, secondField: secondField, fieldLabel: label))
        return self
    }
    
    public func build() -> [Validation] {
        return validations
    }
    
}
