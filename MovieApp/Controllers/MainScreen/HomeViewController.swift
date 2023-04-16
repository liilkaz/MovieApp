//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 01.04.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    // инициализатор для передачи данных о пользователе

    let movieCards = MovieCardsCarusel()
    let movieArray = AllMovies.shared
    var moviesByGenre = [Movie]()
    lazy var categories = CategoryCollectionView()
    lazy var moviesList = MoviesTableView(frame: .zero)
    lazy var scrollView = UIScrollView()
    
    lazy var categoryTitle: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.textAlignment = .left
        label.font = Constants.Fonts.plusJacartaSansBold(with: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var boxOfficeLabel: UILabel = {
        let label = UILabel()
        label.text = "Box Office"
        label.font = Constants.Fonts.plusJacartaSansBold(with: 16)
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("See All", for: .normal)
        button.titleLabel?.font = Constants.Fonts.plusJacartaSansBold(with: 14)
        button.titleLabel?.textAlignment = .right
        button.setTitleColor(UIColor(named: "Onboarding"), for: .normal)
        button.addTarget(nil, action: #selector(seeAllTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var horizontalStack: UIStackView = {
        let st = UIStackView(arrangedSubviews: [boxOfficeLabel, seeAllButton])
        st.axis = .horizontal
        st.spacing = 50
        st.alignment = .leading
        st.translatesAutoresizingMaskIntoConstraints = false
        
        return st
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesByGenre = movieArray.allMovies
        view.backgroundColor = Constants.Colors.backgroundColor
        setupMovieCards()
        setupNavigationTitle()
        setupCategories()
        setupHorizontalStack()
        setupMoviesList()
        categories.didTappedCell = {[weak self] id in
            if id == 0 {
                self?.moviesByGenre = self?.movieArray.allMovies ?? []
            } else {
                self?.moviesByGenre = self?.movieArray.allMovies.filter({ $0.genre_ids[0] == id
                }) ?? []
            }
            self?.moviesList.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - ADDING METHODS

extension HomeViewController {
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(movieCards)
        scrollView.addSubview(categoryTitle)
        scrollView.addSubview(categories)
        scrollView.addSubview(movieCards)
        scrollView.addSubview(horizontalStack)
        scrollView.addSubview(moviesList)
        
        NSLayoutConstraint.activate([
            
            scrollView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            movieCards.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor),
            movieCards.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor),
            movieCards.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor),
            movieCards.heightAnchor.constraint(equalToConstant: 300),
            
            categoryTitle.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor),
            categoryTitle.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor),
            categoryTitle.topAnchor.constraint(equalTo: movieCards.bottomAnchor, constant: 10),
            categoryTitle.heightAnchor.constraint(equalToConstant: 20),
            
            categories.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor),
            categories.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor),
            categories.topAnchor.constraint(equalTo: categoryTitle.bottomAnchor, constant: 10),
            categories.heightAnchor.constraint(equalToConstant: 34),
            
            horizontalStack.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor),
            horizontalStack.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor),
            horizontalStack.topAnchor.constraint(equalTo: categories.bottomAnchor, constant: 10),
            horizontalStack.heightAnchor.constraint(equalToConstant: 20),
            
            moviesList.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor),
            moviesList.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor),
            moviesList.topAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: 10),
            moviesList.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
   
    private func setupMoviesList() {
        view.addSubview(moviesList)
        moviesList.dataSource = self
        moviesList.delegate = self
        
        NSLayoutConstraint.activate([
            moviesList.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            moviesList.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            moviesList.topAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: 10),
            moviesList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupHorizontalStack() {
        view.addSubview(horizontalStack)
        
        NSLayoutConstraint.activate([
            horizontalStack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            horizontalStack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            horizontalStack.topAnchor.constraint(equalTo: categories.bottomAnchor, constant: 10),
            horizontalStack.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupCategories() {
        view.addSubview(categoryTitle)
        view.addSubview(categories)
        
        NSLayoutConstraint.activate([
            categoryTitle.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            categoryTitle.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            categoryTitle.topAnchor.constraint(equalTo: movieCards.bottomAnchor, constant: 10),
            categoryTitle.heightAnchor.constraint(equalToConstant: 20),
            
            categories.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            categories.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            categories.topAnchor.constraint(equalTo: categoryTitle.bottomAnchor, constant: 10),
            categories.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    private func setupMovieCards() {
        view.addSubview(movieCards)
        movieCards.carouselCollectionView.dataSource = self
//        movieCards.delegate = self
        NSLayoutConstraint.activate([
            movieCards.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            movieCards.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            movieCards.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            movieCards.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func setupNavigationTitle() {
        
        let image: UIImageView = {
            let img = UIImageView()
            img.image = UIImage(named: "profileIcon")
            
            return img
        }()
        
        let greeting: UILabel = {
            let label = UILabel()
            label.text = "Hi, Andy"
            label.font = Constants.Fonts.plusJacartaSansBold(with: 18)
            label.textColor = Constants.Colors.mainTextColor
            
            return label
        }()
        
        let description: UILabel = {
            let label = UILabel()
            label.text = "Only stream movie lovers"
            label.font = Constants.Fonts.plusJacartaSansMedium(with: 12)
            label.textColor = Constants.Colors.mainTextColor
            
            return label
        }()
        
        lazy var verticalStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [greeting, description])
            stack.axis = .vertical
            stack.spacing = 5
            stack.alignment = .leading
            stack.distribution = .fill
            
            return stack
        }()
        
        lazy var horizontalStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [image, verticalStack])
            stack.axis = .horizontal
            stack.spacing = 10
            stack.alignment = .leading
            stack.distribution = .fill
            
            return stack
        }()
        
        title = Constants.Titles.NavBar.home
        navigationController?.tabBarItem.title = Constants.Titles.TabBar.title(for: .home)
        navigationItem.leftBarButtonItem = .init(customView: horizontalStack)
        
    }

}

// MARK: - ADDING ACTIONS

extension HomeViewController {
    
    @objc private func seeAllTapped() {
        
    }
    
}

// MARK: - MovieCardDataSourse

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieArray.popularMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCardsCell.identifier,
                                             for: indexPath) as? MovieCardsCell
        else {
            return UICollectionViewCell()
        }
        cell.picture.sd_setImage(with: movieArray.popularMovies[indexPath.row].urlImage)
        cell.filmName.text = movieArray.popularMovies[indexPath.row].title
//        cell.category.text = movieArray.popularMovies[indexPath.row].genre_ids
        return cell
    }
    
}

// MARK: - MovieListDataSourse

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieArray.allMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesCellView.identifier,
                                             for: indexPath) as? MoviesCellView else {
            return UITableViewCell()
        }
        cell.image.sd_setImage(with: moviesByGenre[indexPath.row].urlImage)
        cell.filmName.text = moviesByGenre[indexPath.row].title
        cell.reviewRaitingLabel.text = "\(moviesByGenre[indexPath.row].vote_average)"
        cell.reviewCountLabel.text = "(\(moviesByGenre[indexPath.row].vote_count))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailScreen = MovieDetailViewController()
        print(moviesByGenre[indexPath.row].id)
        detailScreen.id = moviesByGenre[indexPath.row].id
        navigationController?.pushViewController(detailScreen, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
}
