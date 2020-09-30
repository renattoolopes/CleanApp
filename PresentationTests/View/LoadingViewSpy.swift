//
//  LoadingViewSpy.swift
//  PresentationTests
//
//  Created by Renato Lopes on 28/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation
import Presentation

class LoadingViewSpy: LoadingView {
    var viewModel: LoadingViewModel?
    var emit: ((LoadingViewModel) -> Void)?
    
    func observer(completion: @escaping (LoadingViewModel) -> Void) {
        self.emit = completion
    }
    
    func display(viewModel: LoadingViewModel) {
        self.emit?(viewModel)
    }
}
