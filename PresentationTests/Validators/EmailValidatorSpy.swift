//
//  EmailValidatorSpy.swift
//  PresentationTests
//
//  Created by Renato Lopes on 28/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation

class EmailValidatorSpy: EmailValidator {
    var email: String?
    private var isValid: Bool = true
    
    func isValid(email: String) -> Bool {
        self.email = email
        return isValid
    }
    
    func simulatedInvalidEmail() {
        self.isValid = false
    }
}
