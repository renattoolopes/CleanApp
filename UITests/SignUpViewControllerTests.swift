//
//  SignUpViewControllerTests.swift
//  UITests
//
//  Created by Renato Lopes on 29/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import XCTest
import Presentation
import UIKit
@testable import UI

class SignUpViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start() {
        let sut: SignUpViewController = makeSut()
        XCTAssertEqual(sut.loadingIndicator?.isAnimating, false)
    }
    
    func test_sut_implements_loadingView() {
        let sut: SignUpViewController = makeSut()
        XCTAssertNotNil(sut as LoadingView)
    }
    
    func test_sut_implements_alertView() {
        let sut: SignUpViewController = makeSut()
        XCTAssertNotNil(sut as AlertView)
    }
}

extension SignUpViewControllerTests {
    func makeSut() -> SignUpViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let sut: SignUpViewController = storyboard.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        sut.loadViewIfNeeded()
        return sut
    }
}
