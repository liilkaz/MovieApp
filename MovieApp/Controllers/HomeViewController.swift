//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 01.04.2023.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BgColor")
        title = Constants.Titles.NavBar.home
        navigationController?.tabBarItem.title = Constants.Titles.TabBar.title(for: .home)

    }

}
