//
//  Constants.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 01.04.2023.
//

import UIKit

enum Constants {
    enum Colors {
        static var active = UIColor(hexString: "#514EB6")
        static var inactive = UIColor(hexString: "#BFC6CC")
        static var splashBackground = UIColor(named: "Onboarding")
        static var mainTextColor = UIColor(named: "MainTextColor")
        static var otherTextColor = UIColor(hexString: "#78828A")
        static var iconThemeColor = UIColor(named: "IconThemeColor")
    }
    
    enum Titles {
        enum TabBar {
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
        
        enum NavBar {
            static var search = "Search"
            static var recent = "Recent Watch"
            static var home = ""
            static var favorites = "Favorites"
            static var setting = "Setting"
        }
        
        enum Search {
            
        }
        
        enum Recent {
           
        }
        
        enum Home {
            
        }
        
        enum Favorites {
            
        }
        
        enum Setting {
            
        }
    }
    
    enum Icons {
        enum TabBar {
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
    
    enum Fonts {
        static func plusJacartaSansItalic(with size: CGFloat) -> UIFont {
            UIFont(name: "PlusJakartaSans-Italic", size: size) ?? UIFont()
        }
        static func plusJacartaSansLight(with size: CGFloat) -> UIFont {
            UIFont(name: "PlusJakartaSans-Light", size: size) ?? UIFont()
        }
        static func plusJacartaSansMedium(with size: CGFloat) -> UIFont {
            UIFont(name: "PlusJakartaSans-Medium", size: size) ?? UIFont()
        }
        static func plusJacartaSansRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "PlusJakartaSans-Regular", size: size) ?? UIFont()
        }
        static func plusJacartaSansBold(with size: CGFloat) -> UIFont {
            UIFont(name: "PlusJakartaSans-Bold", size: size) ?? UIFont()
        }
        static func plusJacartaSansSemiBold(with size: CGFloat) -> UIFont {
            UIFont(name: "PlusJakartaSans-SemiBold", size: size) ?? UIFont()
        }
        static func montserratMedium(with size: CGFloat) -> UIFont {
            UIFont(name: "Montserrat-Medium", size: size) ?? UIFont()
        }
    }
}
