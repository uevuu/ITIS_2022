//
//  SceneDelegate.swift
//  UIKitBasics
//
//  Created by Teacher on 01.10.2022.
//

import UIKit

/*
 Почему не работают со сторибордами:
 1. Сториборды — XML файлы
 2. Приходится работать со строковыми значениями
 3. Часть настройки будет находиться внутри storyboard файла, а часть в коде
 */

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

