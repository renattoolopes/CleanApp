//
//  RoundedTextField.swift
//  UI
//
//  Created by Renato Lopes on 11/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import UIKit

public final class RoundedTextField: UITextField {

    // MARK: - Intis
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        style()
    }
    
    // MARK: - Private Methods
    func style(radius: CGFloat = 5, andColor color: UIColor = Color.primaryLight) {
        rounded(withRadius: radius, andColor: color)
    }
}
