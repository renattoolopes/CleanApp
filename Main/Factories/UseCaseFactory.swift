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
        return RemoteAddAccount(url: makeURL(path: "signup"), httpPostClient: UseCaseFactory.httpClient)
    }
}
