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
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    public convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Private Methods
    private func setup() {
        navigationBar.barTintColor = Color.primaryDark
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.isTranslucent = false
        navigationBar.barStyle = .black
    }
    
    public func setRootViewController(_ controller: UIViewController) {
        setViewControllers([controller], animated: true)
    }
    
    public func push(viewController: UIViewController) {
        pushViewController(viewController, animated: true)
    }
}
