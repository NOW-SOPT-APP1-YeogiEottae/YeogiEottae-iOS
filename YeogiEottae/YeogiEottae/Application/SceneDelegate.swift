//
//  SceneDelegate.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/13/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = UITabBarController.getDefault()
        self.window?.makeKeyAndVisible()
    }
}
