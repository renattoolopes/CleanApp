//
//  LoginViewController.swift
//  UI
//
//  Created by Renato Lopes on 17/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import UIKit
import Presentation

public class LoginViewController: UIViewController, Storyborded {
    // MARK: - Outlets
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: RoundedTextField!
    @IBOutlet weak var passwordTextField: RoundedTextField!
    
    // MARK: - Reactive Actions
    public var loginEvent: ((LoginViewModel) -> Void)?
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureActions()
        style()
        closeKeyboardWhenTouchedInView()
    }
    
    // MARK: - Private Methods
    private func configureActions() {
        loginButton.addTarget(self, action: #selector(loginButtonTap), for: .touchUpInside)
    }
    
    private func style() {
        title = "4Devs"
        loginButton.rounded(withRadius: 8, andColor: .clear)
    }
    
    @objc
    private func loginButtonTap() {
        let viewModel: LoginViewModel = LoginViewModel(email: emailTextField.text, password: passwordTextField.text)
        loginEvent?(viewModel)
    }
}

// MARK: - LoadingView Extension
extension LoginViewController: LoadingView {
    public func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            self.loadingIndicator?.startAnimating()
        } else {
            self.loadingIndicator?.stopAnimating()
        }
        self.view.isUserInteractionEnabled = !viewModel.isLoading
    }
}

// MARK: - AlertView Extension
extension LoginViewController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        let alert: UIAlertController = UIAlertController(title: viewModel.title, message: viewModel.message , preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
