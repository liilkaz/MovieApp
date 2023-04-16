//
//  ViewController.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 01.04.2023.
//

import UIKit
import SDWebImage

class SearchViewController: UIViewController {
    
    let categories = CategoryCollectionView()
    let movieCategories = FilmCategories.allCases
//    var selectCategory: FilmCategories = .all
//    var detail: DetailedMovie?
//    var runtimes: [Int] = []
//    var searchTimer: Timer?
    var moviesByGenre = [Movie]()
    
    let movieArray = AllMovies.shared
    
    let searchTextField: UITextField = {
        let textField = UITextField(backgroundColor: UIColor(named: "BgColor") ?? UIColor(),
                                    cornerRadius: 24,
                                    placeholder: "Search",
                                    minimumFontSize: 16,
                                    tintColor: Constants.Colors.active,
                                    borderWidth: 1,
                                    borderColor: Constants.Colors.active.cgColor)
        textField.returnKeyType = .go
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setLeftIcon(UIImage(named: "searchField") ?? UIImage())
        textField.setRightIcon(UIImage(named: "searchDivider") ?? UIImage())
        textField.setupRightButton(with: UIImage(named: "filter") ?? UIImage())
        
        return textField
    }()

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor(named: "BgColor")
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        navigationController?.tabBarItem.title = Constants.Titles.TabBar.title(for: .search)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesByGenre = movieArray.allMovies
        view.backgroundColor = UIColor(named: "BgColor")
        title = Constants.Titles.NavBar.search
        view.addSubview(searchTextField)
        view.addSubview(categories)
        view.addSubview(tableView)
        setConstraints()
        categories.didTappedCell = {[weak self] id in
            if id == 0 {
                self?.moviesByGenre = self?.movieArray.allMovies ?? []
            } else {
                self?.moviesByGenre = self?.movieArray.allMovies.filter({ $0.genre_ids[0] == id
                }) ?? []
            }
            self?.tableView.reloadData()
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecentTableViewCell.self, forCellReuseIdentifier: RecentTableViewCell.identifier)
        searchTextField.delegate = self
        hideKeyboardWhenTappedAround()
    }
    
    func fetchSearchedMovies(with searchText: String) {
//        searchTimer?.invalidate()
//        searchTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [weak self] (timer) in
            APICaller.shared.searchMovie(keyWord: searchText) { [weak self] result in
                switch result {
                case .success(let movies):
                    self?.moviesByGenre = movies
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
//                        print(self?.moviesByGenre ?? "where are movies?")
                        self?.searchTextField.text = ""
                        self?.searchTextField.resignFirstResponder()
                    }
                case .failure(let error):
                    print(error)
                }
            }
//        })
    }
    private func setConstraints() {
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.topAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            searchTextField.heightAnchor.constraint(equalToConstant: 52),
            
            categories.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 24),
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

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return moviesByGenre.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 180
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentTableViewCell.identifier,
                                                       for: indexPath) as? RecentTableViewCell else { return UITableViewCell() }
        cell.filmNameLabel.text = moviesByGenre[indexPath.row].title
        cell.movieImage.sd_setImage(with: moviesByGenre[indexPath.row].urlImage)
        cell.dateLabel.text = moviesByGenre[indexPath.row].textDate
        
//        cell.timeLabel.text = "\(runtimes[indexPath.row]) minutes"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailScreen = MovieDetailViewController()
        detailScreen.id = moviesByGenre[indexPath.row].id
        navigationController?.pushViewController(detailScreen, animated: true)
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let word = searchTextField.text {
            fetchSearchedMovies(with: word)
        }
        return true
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
////        var word = searchTextField.text
//        if let word = searchTextField.text {
//            fetchSearchedMovies(with: word)
//        }
//    }
}


// extension SearchViewController {
//    func getMovies() {
//        APICaller.shared.getPopularMovies { [weak self] result in
//            switch result {
//            case .success(let movies):
//                DispatchQueue.main.async {
//                    self?.movies = movies
//                    movies.forEach { movies in
//
//                        self?.getRuntimes(id: movies.id)
//                    }
//                    print(self?.movies ??  "where are movies?")
//
//                    self?.tableView.reloadData()
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//    func getRuntimes(id: Int) {
//        APICaller.shared.getDetailedMovie(with: id) { [weak self] result in
//            switch result {
//            case .success(let movie):
////                DispatchQueue.main.async {
//                    self?.runtimes.append((movie.runtime)!)
////                    print(self?.runtimes)
////                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//    func getMoviesByGenres(genre: Int) {
//        print(genre)
//        APICaller.shared.getMoviesByGenre(with: genre) { [weak self] result in
//            switch result {
//            case .success(let movies):
//                DispatchQueue.main.async {
//                    self?.movies = movies
//                    self?.tableView.reloadData()
//                }
//                print(self?.movies)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//
//    }
//}
