//
//  ViewController.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 01.04.2023.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BgColor")
        navigationItem.title = Constants.Titles.NavBar.search
        navigationController?.tabBarItem.title = Constants.Titles.TabBar.title(for: .search)
    }
}
