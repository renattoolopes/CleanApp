//
//  SignUpComposer.swift
//  Main
//
//  Created by Renato Lopes on 06/10/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation
import Domain
import UI

public final class SignUpComposer {
    public static func composeController(withAddAccount addAccount: AddAccount) -> SignUpViewController {
        return ControllerFactory.makeSignUpController(addAccount: addAccount)
    }
}
