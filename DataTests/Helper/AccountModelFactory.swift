//
//  AccountModelFactory.swift
//  DataTests
//
//  Created by Renato Lopes on 21/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation
import Domain

public func makeAddAccountModel() -> AddAccountModel {
    return  AddAccountModel(name: "any_name",
                            email: "any_email",
                            password: "any_password",
                            passwordConfirmation: "any_password")
}
