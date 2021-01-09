//
//  Model.swift
//  Domain
//
//  Created by Renato Lopes on 07/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation

public protocol Model: Codable, Equatable {}

public extension Model {
    func convertToData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
    
    func convertToJson() -> [String: Any]? {
        guard let data: Data = self.convertToData() else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
}
