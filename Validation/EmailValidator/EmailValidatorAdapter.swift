//
//  EmailValidatorAdapter.swift
//  Validation
//
//  Created by Renato Lopes on 30/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation
import Presentation

public final class EmailValidatorAdapter: EmailValidator {
    // MARK: - Private Properties
    private let pattern: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    // MARK: - Public Methods
    public func isValid(email: String) -> Bool {
        let range = NSRange(location: 0, length: email.utf8.count)
        let regex = try? NSRegularExpression(pattern: pattern)
        return regex?.firstMatch(in: email, range: range) != nil
    }
    
    public init() { }
}
