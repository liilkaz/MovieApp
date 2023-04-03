//
//  Constants.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 01.04.2023.
//

import UIKit

enum K{
    enum Colors{
        static var active = UIColor(hexString: "#514EB6")
        static var inactive = UIColor(hexString: "#BFC6CC")
        static var splashBackground = UIColor(named: "Onboarding")
    }
    
    enum Titles{
        enum TabBar{
            static func title(for tab: Tabs) -> String? {
                switch tab {
                case .search: return ""
                case .recent: return ""
                case .home: return ""
                case .favorites: return ""
                case .setting: return ""
                }
            }
        }
        
        enum NavBar{
            static var search = "Search"
            static var recent = "Recent Watch"
            static var home = ""
            static var favorites = "Favorites"
            static var setting = "Setting"
        }
        
        enum Search{
            
        }
        
        enum Recent{
           
        }
        
        enum Home{
            
        }
        
        enum Favorites{
            
        }
        
        enum Setting{
            
        }
    }
    
    enum Icons{
        enum TabBar{
            static func inactiveIcon(for tab: Tabs) -> UIImage? {
                switch tab {
                case .search: return UIImage(named: "searchTab")
                case .recent: return UIImage(named: "recent")
                case .home: return UIImage(named: "home")
                case .favorites: return UIImage(named: "favorite")
                case .setting: return UIImage(named: "user")
                }
            }
            static func activeIcon(for tab: Tabs) -> UIImage? {
                switch tab {
                case .search: return UIImage(named: "activeSearch")
                case .recent: return UIImage(named: "activeRecent")
                case .home: return UIImage(named: "home")
                case .favorites: return UIImage(named: "activeFavorite")
                case .setting: return UIImage(named: "activeSetting")
                }
            }
            
        }
    }
    
    enum Fonts{
       
    }
}
