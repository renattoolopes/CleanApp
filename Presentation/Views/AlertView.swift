//
//  AlertView.swift
//  Presentation
//
//  Created by Renato Lopes on 30/11/20.
//

import Foundation

public struct AlertViewModel: Equatable {
    // MARK: - Public Properties
    public var title: String
    public var message: String
    
    // MARK: - Initializers
    public init(title: String, message: String) {
        self.title = title
        self.message = message
    }
}

// MARK: - Protocols
public protocol AlertView {
    // MARK: - Methods
    func showMessage(viewModel: AlertViewModel)
}
