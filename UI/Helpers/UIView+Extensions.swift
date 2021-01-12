//
//  UIView+Extensions.swift
//  UI
//
//  Created by Renato Lopes on 11/01/21.
//  Copyright © 2021 Renato Lopes. All rights reserved.
//

import UIKit

public extension UIView {
    
    func rounded(withRadius radius: CGFloat, andColor color: UIColor) {
        layer.cornerRadius = radius
        layer.borderWidth = 1
        layer.borderColor = color.cgColor
    }
}
