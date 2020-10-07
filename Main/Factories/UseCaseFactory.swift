//
//  UseCaseFactory.swift
//  Main
//
//  Created by Renato Lopes on 06/10/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation

import Domain
import Data
import Infra

final class UseCaseFactory {
    private static let httpClient: AlamofireAdapter = AlamofireAdapter()
    private static let apiBaseURL: String = Environment.variable(.apiBaseUrl)
    
    private static func makeURL(path: String) -> URL {
        return URL(string: "\(apiBaseURL)/\(path)")!
    }
    
    static func makeRemoteAddAccount() -> AddAccount {
        let addAccount: RemoteAddAccount = RemoteAddAccount(url: makeURL(path: "signup"), httpPostClient: UseCaseFactory.httpClient)
        return MainQueueDispatchDecorator(addAccount)
    }
}


public final class MainQueueDispatchDecorator<T> {
    private let instance: T
    
    public init(_ instance: T) {
        self.instance = instance
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else { return DispatchQueue.main.async(execute: completion) }
        completion()
    }
}


extension MainQueueDispatchDecorator: AddAccount where T: AddAccount {
    public func add(account: AddAccountModel, compleiton: @escaping AddAccountResult) {
        instance.add(account: account) { [weak self] (result) in
            self?.dispatch {
                compleiton(result)
            }
        }
    }
}
