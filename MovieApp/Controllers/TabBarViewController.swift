//
//  TabBarViewController.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 01.04.2023.
//

import UIKit

enum Tabs: Int, CaseIterable {
    case search
    case recent
    case home
    case favorites
    case setting
}

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        tabBar.backgroundColor = UIColor(named: "TabBarColor")

        let controllers: [NavigationBarController] = Tabs.allCases.map { tab in
            let controller = NavigationBarController(rootViewController: getController(for: tab))
            
            controller.tabBarItem = UITabBarItem(title: Constants.Titles.TabBar.title(for: tab),
                                       image: Constants.Icons.TabBar.inactiveIcon(for: tab)?.withRenderingMode(.alwaysOriginal),
                                       selectedImage: Constants.Icons.TabBar.activeIcon(for: tab)?.withRenderingMode(.alwaysOriginal))
            
            return controller
                                                     
        }
        setViewControllers(controllers, animated: false)
        selectedIndex = 2
    }
    
    private func getController(for tab: Tabs) -> UIViewController {
        switch tab {
        case .search: return SearchViewController()
        case .recent: return RecentViewController()
        case .home: return HomePageViewController()
        case .favorites: return FavorivesViewController()
        case .setting: return SettingViewController()
        }
    }
}
