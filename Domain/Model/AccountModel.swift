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
    public var accessToken: String
    
    // MARK: - Initializers
    public init(accessToken: String) {
        self.accessToken = accessToken
    }
}
