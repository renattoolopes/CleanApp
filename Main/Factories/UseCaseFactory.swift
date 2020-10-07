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
    static func makeRemoteAddAccount() -> AddAccount {
        let service: AlamofireAdapter = AlamofireAdapter()
        let url: URL = URL(string: "https://clean-node-api.herokuapp.com/api/signup")!
        return RemoteAddAccount(url: url, httpPostClient: service)
    }
}
