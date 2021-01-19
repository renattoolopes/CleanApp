//
//  SceneDelegate.swift
//  Main
//
//  Created by Renato Lopes on 30/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import UIKit
import UI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navigation: NavigationController = NavigationController()
        let controller: SignUpViewController = SingUpFactory.composeController(withAddAccount: makeRemoteAddAccount())
        navigation.setRootViewController(controller)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}

