//
//  MainQueueDispatchDecorator.swift
//  Main
//
//  Created by Renato Lopes on 07/10/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation
import Domain

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
