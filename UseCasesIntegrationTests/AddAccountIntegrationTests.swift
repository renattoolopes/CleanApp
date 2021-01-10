//
//  AddAccountIntegrationTests.swift
//  UseCasesIntegrationTests
//
//  Created by Renato Lopes on 20/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import XCTest
import Data
import Infra
import Domain

class AddAccountIntegrationTests: XCTestCase {

    func test_add_account() {
        let alamofireAdapter: AlamofireAdapter = AlamofireAdapter()
        let url: URL = URL(string: "https://fordevs.herokuapp.com/api/signup")!
        let accountModel: AddAccountModel = AddAccountModel(name: "Renato Lopes", email: "renattoolopes@gmail.com", password: "123123", passwordConfirmation: "123123")
        let sut: RemoteAddAccount = RemoteAddAccount(url: url, httpPostClient: alamofireAdapter)
        
        let promise = expectation(description: "SignUp")
        // Call add to signup
        sut.add(account: accountModel) { (result) in
            switch result {
            case .success(let account):
                XCTAssertNotNil(account.accessToken)
            case .failure(let error): XCTFail("Expected Success, but returned: \(error)")
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }
}
