//
//  ValidationComposite.swift
//  Validation
//
//  Created by Renato Lopes on 09/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import Foundation
import Presentation

public class ValidationComposite: Validation {
    private let validations: [Validation]
    
    public init(validations: [Validation]) {
        self.validations = validations
    }
    
    public func validate(data: [String : Any]?) -> String? {
        
        for validation in validations {
            guard let errorMessage: String = validation.validate(data: data) else { continue }
            return errorMessage
        }
        
        return nil
    }
}
