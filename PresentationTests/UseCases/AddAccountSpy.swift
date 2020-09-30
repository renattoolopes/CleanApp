//
//  AddAccountSpy.swift
//  PresentationTests
//
//  Created by Renato Lopes on 29/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation
import Domain

// Mock AddAccount
class AddAccountSpy: AddAccount {
    public var addAccountModel: AddAccountModel?
    public var compleiton: AddAccountResult?
    
    func add(account: AddAccountModel, compleiton: @escaping AddAccountResult) {
        self.addAccountModel = account
        self.compleiton = compleiton
    }
    
    func completionWithError(_ error: DomainError) {
        self.compleiton?(.failure(error))
    }
    
    func completeWithAccountSpy(_ account: AccountModel) {
        self.compleiton?(.success(account))
    }
}
