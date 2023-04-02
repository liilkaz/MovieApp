//
//  RecentViewController.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 01.04.2023.
//

import UIKit

class RecentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BgColor")
        title = K.Titles.NavBar.recent
        navigationController?.tabBarItem.title = K.Titles.TabBar.title(for: .recent)
    }

}
