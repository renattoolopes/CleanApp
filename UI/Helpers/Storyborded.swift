//
//  Storyborded.swift
//  UI
//
//  Created by Renato Lopes on 30/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation
import UIKit

public protocol Storyborded {
    static func instantiate() throws -> Self
}



extension Storyborded where Self: UIViewController {
    public static func instantiate() throws -> Self {
        let viewControllerName: String =  String(describing: self)
        guard let storyboardName: String = viewControllerName.components(separatedBy: "ViewController").first else {
            throw NSError()
        }
        let bundle: Bundle = Bundle(for: Self.self)
        let storyboard: UIStoryboard = UIStoryboard(name: storyboardName, bundle: bundle)
        guard let viewController: Self = storyboard.instantiateViewController(identifier: viewControllerName) as? Self else {
            throw NSError()
        }
        return viewController
    }
}
