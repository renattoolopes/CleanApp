//
//  SignUpViewController.swift
//  UI
//
//  Created by Renato Lopes on 29/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation
import Presentation
import UIKit


protocol SignUpEventsProtocol {
    var signUp: ((SignUpViewModel) -> Void)? { get set }
}

final class SignUpViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!

    // MARK: - Reactive Actions
    var signUp: ((SignUpViewModel) -> Void)?
    
    // MARK: - Private Properties
    private lazy var signUpViewModel: SignUpViewModel = {
        let name: String? = nameTextField?.text
        let email: String? = emailTextField?.text
        let password: String? = passwordTextField?.text
        let passwordConfirmation: String? = passwordConfirmationTextField?.text
        return SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private Methods
    private func configure() {
        saveButton.addTarget(self, action: #selector(saveButtonTap), for: .touchUpInside)
    }
    
    @objc
    private func saveButtonTap() {
        signUp?(signUpViewModel)
    }
}

// MARK: - LoadingView Extension
extension SignUpViewController: LoadingView {
    public func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            loadingIndicator?.startAnimating()
        } else {
            loadingIndicator?.stopAnimating()
        }
    }
}

extension SignUpViewController: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        let alert: UIAlertController = UIAlertController(title: viewModel.title, message: viewModel.message , preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
