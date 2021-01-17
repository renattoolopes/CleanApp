//
//  RemoteAuthentication.swift
//  Data
//
//  Created by Renato Lopes on 17/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import Foundation
import Domain

public class RemoteAuthentication: Authentication {
    // MARK: - Public Properties
    public var url: URL
    public var httpClient: HttpPostClient
    
    // MARK: - Initializers
    public init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func auth(with model: AuthenticationModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
        httpClient.post(to: url, with: model.convertToData()) {[weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let data):
                if let accountModel: AccountModel = data?.convertToModel() {
                    completion(.success(accountModel))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure(let error):
                switch error {
                case .unauthorized:
                    completion(.failure(.expiredSession))
                default:
                    completion(.failure(.unexpected))
                }
            }
        }
    }
}
