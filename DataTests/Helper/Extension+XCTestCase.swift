//
//  Extension+XCTestCase.swift
//  DataTests
//
//  Created by Renato Lopes on 15/09/20.
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
}
