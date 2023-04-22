//
//  RecentViewController.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 01.04.2023.
//

import UIKit

class RecentViewController: UIViewController {
    
    let categories = CategoryCollectionView()
    let movieCategories = FilmCategories.allCases
    var moviesByGenre = [Movie]()
    var allMovieArray = AllMovies.shared
    var recentsMovieArray = [Movie]()

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
        getRecentsMovies()
        navigationController?.tabBarItem.title = Constants.Titles.TabBar.title(for: .recent)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRecentsMovies()

        view.backgroundColor = UIColor(named: "BgColor")
        title = Constants.Titles.NavBar.recent
        view.addSubview(categories)
        view.addSubview(tableView)
        setConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecentTableViewCell.self, forCellReuseIdentifier: RecentTableViewCell.identifier)
        
        categories.didTappedCell = {[weak self] id in
            if id == 0 {
                self?.moviesByGenre = self?.recentsMovieArray ?? []
            } else {
                self?.moviesByGenre = self?.recentsMovieArray.filter({ $0.genre_ids[0] == id
                }) ?? []
            }
            self?.tableView.reloadData()
        }
    }

    private func getRecentsMovies() {
        let recentsID = userDataSource.getRecents(for: AllMovies.shared.userId)
        recentsMovieArray.removeAll() //?
        allMovieArray.allMovies.forEach { movie in
            if recentsID.contains(where: { movieModel in
                movieModel.movieId == movie.id
            }) {
                recentsMovieArray.append(movie)
            }
        }
        let nonDubleRecent = Set(recentsMovieArray)
        recentsMovieArray = Array(nonDubleRecent)
        moviesByGenre = recentsMovieArray
        tableView.reloadData()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            categories.topAnchor.constraint(equalTo: view.topAnchor),
            categories.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            categories.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categories.heightAnchor.constraint(equalToConstant: 34),
            
            tableView.topAnchor.constraint(equalTo: categories.topAnchor, constant: 42),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSourse

extension RecentViewController: UITableViewDelegate, UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return moviesByGenre.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 180
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RecentTableViewCell.identifier,
            for: indexPath) as? RecentTableViewCell
        else {
            return UITableViewCell()
        }
        let isFavorite = userDataSource.isFavorites(for: AllMovies.shared.userId, with: moviesByGenre[indexPath.row].id)
        cell.configure(url: moviesByGenre[indexPath.row].urlImage,
                       movieName: moviesByGenre[indexPath.row].title, date: moviesByGenre[indexPath.row].textDate, movieId: moviesByGenre[indexPath.row].id,
                       isFavorite: isFavorite)
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailScreen = MovieDetailViewController()
        let isFavorite = userDataSource.isFavorites(for: AllMovies.shared.userId, with: moviesByGenre[indexPath.row].id)
        detailScreen.isFavorite = isFavorite
        detailScreen.id = moviesByGenre[indexPath.row].id
        navigationController?.pushViewController(detailScreen, animated: true)
    }
    
}
