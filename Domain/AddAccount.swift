//
//  AddAccount.swift
//  Domain
//
//  Created by Renato Lopes on 07/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation

protocol AddAccount {
    // MARK: - Type Values
    typealias AddAccountResult = (Result<AccountModel, Error>) -> Void
    
    // MARK: - Methods
    func add(account: AddAccountModel, compleiton: @escaping AddAccountResult)
}

struct AddAccountModel {
    var name: String
    var email: String
    var password: String
    var passwordConfirmation: String
}
