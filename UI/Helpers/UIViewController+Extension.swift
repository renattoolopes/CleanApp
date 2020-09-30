//
//  UIViewController+Extension.swift
//  UI
//
//  Created by Renato Lopes on 30/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// This method add event to close the keyboard when view is touched
    func closeKeyboardWhenTouchedInView() {
        let keyName: String = "\(#file)_\(#function)_close_keyboard"
        if let removeGesture: UIGestureRecognizer = view.gestureRecognizers?.first(where: { $0.name == keyName }) {
            view.removeGestureRecognizer(removeGesture)
        }
        let gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        gesture.name = keyName
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }
    
    @objc
    private func closeKeyboard() {
        view.endEditing(true)
    }
}
