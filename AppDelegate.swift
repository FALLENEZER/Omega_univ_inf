//
//  AppDelegate.swift
//  Omega_final_univ
//
//  Created by Даниил Игумнов on 01.08.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Настройка внешнего вида navigation bar
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // Используйте configureWithTransparentBackground() если нужен прозрачный фон
        appearance.backgroundColor = UIColor.systemBlue // Установите нужный цвет
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // Установите цвет текста

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        return true
    }

    // Остальные методы...
}
