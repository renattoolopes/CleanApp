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

public func makeRemoteAddAccount() -> AddAccount {
    let addAccount: RemoteAddAccount = RemoteAddAccount(url: makeURL(path: "signup"), httpPostClient: alamofireFactory())
    return MainQueueDispatchDecorator(addAccount)
}

