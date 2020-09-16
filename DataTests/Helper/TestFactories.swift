//
//  TestFactories.swift
//  DataTests
//
//  Created by Renato Lopes on 10/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation
import XCTest


public func makeInvalidData() -> Data {
    return Data("Invalid_data".utf8)
}

public func makeValidData() -> Data {
    return Data("{\"name\":\"Renato\"}".utf8)
}

public func makeError() -> Error {
    return NSError(domain: "any_error", code: 0)
}

public func makeFakeURL() -> URL? {
    return URL(string: "https://any-url.com")
}

public func makeResponse(statusCode: Int) -> HTTPURLResponse? {
    return HTTPURLResponse(url: makeFakeURL()!, statusCode: statusCode, httpVersion: nil, headerFields: nil)
}

public func makeEmptyData() -> Data {
    return Data()
}
