//
//  NavigationController.swift
//  UI
//
//  Created by Renato Lopes on 11/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import UIKit

public final class NavigationController: UINavigationController {
    
    // MARK: - Inits
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Private Methods
    private func setup() {
        navigationBar.barTintColor = Color.primaryDark
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.isTranslucent = false
        navigationBar.barStyle = .black
    }
}
