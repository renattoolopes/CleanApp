//
//  Validation.swift
//  Presentation
//
//  Created by Renato Lopes on 22/10/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation

public protocol Validation {
    func validate(data: [String: Any]?) -> String?
}
