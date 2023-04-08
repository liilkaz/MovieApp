//
//  SceneDelegate.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 01.04.2023.
//

import UIKit
import FirebaseCore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        FirebaseApp.configure()
        runMainFlow()
        window?.makeKeyAndVisible()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

    private func runMainFlow() {
        startApp()

    }

    private func startApp() {

        window?.rootViewController = SplashViewController()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0) { [weak self] in
            let navigationController = UINavigationController(rootViewController: LoginViewController())
            self?.window?.rootViewController = navigationController
        }
    }

}
