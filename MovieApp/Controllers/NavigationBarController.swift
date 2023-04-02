//
//  NavigationBarController.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 01.04.2023.
//

import UIKit

class NavigationBarController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
        view.backgroundColor = UIColor(named: "BgColor")
        navigationBar.isTranslucent = false
        navigationBar.standardAppearance.titleTextAttributes = [
            .foregroundColor: UIColor(named: "MainTextColor") ?? UIColor(),
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
//        navigationBar.addBottomBorder(with: Resourses.Colors.separator, height: 1)
    }
    

}

