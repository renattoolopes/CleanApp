//
//  CompareFieldsValidation.swift
//  Validation
//
//  Created by Renato Lopes on 09/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import Foundation
import Presentation

public class CompareFieldsValidation: Validation {
    private let firstField: String
    private let secondField: String
    private let fieldLabel: String
    
    public init(firstField: String, secondField: String, fieldLabel: String) {
        self.firstField = firstField
        self.secondField = secondField
        self.fieldLabel = fieldLabel
    }
    
    public func validate(data: [String : Any]?) -> String? {
        guard let firstValue: String = data?[firstField] as? String,
              let secondValue: String = data?[secondField] as? String,
              firstValue == secondValue
        else { return "O campo \(fieldLabel) é inválido" }
        return nil
    }
    
}
