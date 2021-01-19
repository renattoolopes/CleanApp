//
//  WellcomeViewController.swift
//  UI
//
//  Created by Renato Lopes on 18/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import UIKit

public final class WellcomeViewController: UIViewController, Storyborded {
    // MARK: - Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    // MARK: - Reactive Actions
    public var loginEvent: (() -> Void)?
    public var signUpEvent: (() -> Void)?

    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureActions()
        style()
    }
    
    // MARK: - Private Methods
    private func configureActions() {
        loginButton.addTarget(self, action: #selector(loginButtonTap), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTap), for: .touchUpInside)

    }
    
    private func style() {
        title = "4Devs"
        loginButton.rounded(withRadius: 8, andColor: .clear)
        signUpButton.rounded(withRadius: 8, andColor: .clear)
    }
    
    @objc
    private func loginButtonTap() {
        loginEvent?()
    }
    
    @objc
    private func signUpButtonTap() {
        signUpEvent?()
    }
    
}
