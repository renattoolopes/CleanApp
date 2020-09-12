//
//  Extension+XCTestCase.swift
//  DataTests
//
//  Created by Renato Lopes on 10/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
    public func checkMemoryLeak(for object: AnyObject, inFile file: StaticString = #file, andLine line: UInt = #line) {
        addTeardownBlock { [weak object] in
            XCTAssertNil(object, file: file, line: line)
        }
    }
    
    public func makeInvalidData() -> Data {
        return Data("Invalid_data".utf8)
    }
    
    public func makeValidData() -> Data {
        return Data("{\"name\":\"Renato\"}".utf8)
    }
}
