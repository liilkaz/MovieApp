//
//  FavorivesViewController.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 01.04.2023.
//

import UIKit

class FavorivesViewController: UIViewController {
    
    let movieArray = AllMovies.shared
    private var favorites = [Movie]()

    private let userDataSource = UserDataSource()

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor(named: "BgColor")
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
        navigationController?.tabBarItem.title = Constants.Titles.TabBar.title(for: .favorites)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFavorites()
        view.backgroundColor = UIColor(named: "BgColor")
        title = Constants.Titles.NavBar.favorites
        view.addSubview(tableView)
        setConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecentTableViewCell.self, forCellReuseIdentifier: RecentTableViewCell.identifier)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }

    private func getFavorites() {
        let favoritesID = userDataSource.getFavorites(for: AllMovies.shared.userId)
        favorites.removeAll()
        AllMovies.shared.allMovies.forEach { movie in
            if favoritesID.contains(where: { movieModel in
                movieModel.movieId == movie.id
            }) {
                favorites.append(movie)
            }
        }
        let nonDubleFavorite = Set(favorites)
        favorites = Array(nonDubleFavorite)
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSourse

extension FavorivesViewController: UITableViewDelegate, UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favorites.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 180
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentTableViewCell.identifier,
                                                       for: indexPath) as? RecentTableViewCell else { return UITableViewCell() }
        cell.filmNameLabel.text = favorites[indexPath.row].title
        cell.movieImage.sd_setImage(with: favorites[indexPath.row].urlImage)
        cell.dateLabel.text = favorites[indexPath.row].textDate
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailScreen = MovieDetailViewController()
        navigationController?.pushViewController(detailScreen, animated: true)
    }
    
}
