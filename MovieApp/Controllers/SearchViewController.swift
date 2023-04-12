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
    var movie: [Movie]?
    var detail: DetailedMovie?
    
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
        navigationController?.tabBarItem.title = Constants.Titles.TabBar.title(for: .search)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BgColor")
        title = Constants.Titles.NavBar.search
        view.addSubview(searchTextField)
        view.addSubview(categories)
        view.addSubview(tableView)
        setConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecentTableViewCell.self, forCellReuseIdentifier: RecentTableViewCell.identifier)
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
        
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 180
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentTableViewCell.identifier,
                                                       for: indexPath) as? RecentTableViewCell else { return UITableViewCell() }
        APICaller.shared.getPopularMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movie = movies
                DispatchQueue.main.async {
                    print(self?.movie ??  "where are movies?")
                    print(self?.movie?[indexPath.row].id)
                    cell.filmNameLabel.text = self?.movie?[indexPath.row].title
                    cell.movieImage.sd_setImage(with:
                                                    URL(string: "\(NetworkConstants.imageUrl + (self?.movie?[indexPath.row].poster_path)!)?api_key=\(NetworkConstants.apiKey)"))
                    cell.dateLabel.text = self?.movie?[indexPath.row].release_date
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        APICaller.shared.getDetailedMovie(with: self.movie?[indexPath.row].id ?? 1) { [weak self] result in
            switch result {
            case .success(let movie):
                self?.detail = movie
                DispatchQueue.main.async {
                    cell.timeLabel.text = "\(self!.detail!.runtime) minutes"
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailScreen = MovieDetailViewController()
        detailScreen.id = movie?[indexPath.row].id
        navigationController?.pushViewController(detailScreen, animated: true)
    }
    
}
