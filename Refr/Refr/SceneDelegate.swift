//
//  SceneDelegate.swift
//  Refr
//
//  Created by 전도균 on 2022/11/14.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
//        window?.rootViewController = ProductViewController()
        window?.rootViewController = HomeViewController()
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
    }


}

