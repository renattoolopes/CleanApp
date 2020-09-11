//
//  AccountModel.swift
//  Domain
//
//  Created by Renato Lopes on 07/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation

public struct AccountModel: Model {
    // MARK: - Public Properties
    public var id: String
    public var name: String
    public var email: String
    public var password: String
    
    // MARK: - Initializers
    public init(id: String,
                name: String,
                email: String,
                password: String) {
        
        self.name = name
        self.email = email
        self.password = password
        self.id = id
    }
}
