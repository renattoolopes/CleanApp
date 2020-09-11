//
//  AccountModelFactory.swift
//  Data
//
//  Created by Renato Lopes on 10/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation
import Domain

public func makeAccountModel() -> AccountModel {
    return AccountModel(id: "100",
                        name: "Renato Lopes",
                        email: "renattoolopes@gmail.com",
                        password: "123123")
}
