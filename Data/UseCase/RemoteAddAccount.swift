//
//  RemoteAddAccount.swift
//  Data
//
//  Created by Renato Lopes on 07/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation
import Domain

public final class RemoteAddAccount: AddAccount {    
    // MARK: - Public Properties
    public var url: URL
    public var httpPostClient: HttpPostClient
    
    // MARK: - Initializers
    public init(url: URL, httpPostClient: HttpPostClient) {
        self.url = url
        self.httpPostClient = httpPostClient
    }
    
    // MARK: - Public Methods
    public func add(account accountModel: AddAccountModel, compleiton completion: @escaping AddAccountResult) {
        self.httpPostClient.post(to: self.url, with: accountModel.convertToData()) { result in
            switch result {
            case .success(let data):
                if let accountModel: AccountModel = data.convertToModel() {
                    completion(.success(accountModel))
                }
            case .failure:
                completion(.failure(.unexpected))
            }
        }
    }
}
