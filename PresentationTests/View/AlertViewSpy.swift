//
//  AlertViewSpy.swift
//  PresentationTests
//
//  Created by Renato Lopes on 28/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation

class AlertViewSpy: AlertView {
    // MARK: - Public Properties
    public var emit: ((AlertViewModel) -> Void)?
    
    // MARK: - Public Methods
    func showMessage(viewModel: AlertViewModel) {
        self.emit?(viewModel)
    }
    
    func observer(completion: @escaping (AlertViewModel) -> Void) {
        self.emit = completion
    }
}
