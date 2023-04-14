//
//  Theme.swift
//  
//
//  Created by Djinsolobzik on 15.03.2023.
//

import UIKit

enum Theme: Int, CaseIterable {
    case light
    case dark
}

extension Theme {

    // Обертка для UserDefaults

    @PersistTheme(key: "app_theme", defaultValue: Theme.light.rawValue)
    private static var appTheme: Int

    // Сохранение темы в UserDefaults
    func save() {
        Theme.appTheme = self.rawValue
    }

    // Текущая тема приложения
    static var current: Theme {
        Theme(rawValue: appTheme) ?? .light
    }
}

extension Theme {

    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light: return .light
        case .dark: return .dark
        }
    }
}
