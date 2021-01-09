//
//  RequiredFieldValidation.swift
//  Validation
//
//  Created by Renato Lopes on 09/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import Foundation
import Presentation

public final class RequiredFieldValidation: Validation {
    // MARK: - Private Properties
    private let fieldName: String
    private let fieldLabel: String
    
    // MARK: - Inits
    public init(fieldName: String, fieldLabel: String) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
    }
    
    // MARK: - Public Methods
    public func validate(data: [String : Any]?) -> String? {
        guard let value: String = data?[self.fieldName] as? String, !value.isEmpty, value.count > 0 else { return "O campo \(fieldLabel) é obrigatório" }
        return nil
    }
}
