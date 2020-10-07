//
//  WeakVarProxy.swift
//  Main
//
//  Created by Renato Lopes on 06/10/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation
import Presentation

final class WeakVarProxy<T: AnyObject> {
    // MARK: - Private Properties
    private weak var instance: T?
    
    // MARK: - Initializers
    init(_ instance: T) {
        self.instance = instance
    }
}

// MARK: - WeakVarProxy Extension
extension WeakVarProxy: AlertView where T: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        instance?.showMessage(viewModel: viewModel)
    }
}

extension WeakVarProxy: LoadingView where T: LoadingView {
    func display(viewModel: LoadingViewModel) {
        instance?.display(viewModel: viewModel)
    }
}
