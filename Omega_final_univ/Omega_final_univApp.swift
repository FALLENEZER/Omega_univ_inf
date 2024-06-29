//
//  Omega_final_univApp.swift
//  Omega_final_univ
//
//  Created by Даниил Игумнов on 27.06.2024.
//

import SwiftUI

@main
struct Omega_final_univApp: App {
    var body: some Scene {
        let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
        
        WindowGroup {
            ContentView()
        }
    }
}

