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
    var signUp: ((SignUpRequest) -> Void)? { get set }
    var loading: () -> Void { get }
}

public final class SignUpViewController: UIViewController, Storyborded {
    // MARK: - Outlets
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField: RoundedTextField!
    @IBOutlet weak var emailTextField: RoundedTextField!
    @IBOutlet weak var passwordTextField: RoundedTextField!
    @IBOutlet weak var passwordConfirmationTextField: RoundedTextField!

    // MARK: - Reactive Actions
    public var signUp: ((SignUpRequest) -> Void)?
    lazy var loading: (_ isLoading: Bool ) -> Void = { [weak self] isLoading in
        
        guard let self: SignUpViewController = self else { return }
        if isLoading {
            self.loadingIndicator?.startAnimating()
        } else {
            self.loadingIndicator?.stopAnimating()
        }
        self.view.isUserInteractionEnabled = !isLoading
    }
    
    // MARK: - Private Properties
    private var signUpViewModel: SignUpRequest {
        let name: String? = nameTextField?.text
        let email: String? = emailTextField?.text
        let password: String? = passwordTextField?.text
        let passwordConfirmation: String? = passwordConfirmationTextField?.text
        return SignUpRequest(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
    }
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureActions()
        style()
        closeKeyboardWhenTouchedInView()
    }
    
    // MARK: - Private Methods
    private func configureActions() {
        saveButton.addTarget(self, action: #selector(saveButtonTap), for: .touchUpInside)
    }
    
    private func style() {
        title = "4Devs"
        saveButton.rounded(withRadius: 8, andColor: .clear)
    }
    
    @objc
    private func saveButtonTap() {
        signUp?(signUpViewModel)
    }
}

// MARK: - LoadingView Extension
extension SignUpViewController: LoadingView {
    public func display(viewModel: LoadingViewModel) {
        loading(viewModel.isLoading)
    }
}

// MARK: - AlertView Extension
extension SignUpViewController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        let alert: UIAlertController = UIAlertController(title: viewModel.title, message: viewModel.message , preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
