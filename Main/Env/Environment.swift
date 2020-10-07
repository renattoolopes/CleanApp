//
//  Environment.swift
//  Main
//
//  Created by Renato Lopes on 06/10/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation

public final class Environment {
    public enum EnvironmentVariables: String {
        case apiBaseUrl = "API_BASE_URL"
    }
    
    public static func variable(_ key: EnvironmentVariables) -> String {
        guard let variable: String =  Bundle.main.infoDictionary?[key.rawValue] as? String else {
            return String()
        }
        return variable
    }
}
