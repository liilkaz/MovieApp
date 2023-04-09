//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 01.04.2023.
//

import UIKit

class HomeViewControllerSecond: UIViewController {
    
    let movieCards = MovieCardsCollectionView()
    lazy var categories = CategoryCollectionView()
    lazy var moviesList = MoviesTableView(frame: .zero)
    lazy var scrollView = UIScrollView()
    
    lazy var categoryTitle: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.textAlignment = .left
        label.font = Constants.Fonts.plusJacartaSansBold(with: 16)
        label.textColor = UIColor(named: "Onboarding")
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var boxOfficeLabel: UILabel = {
        let label = UILabel()
        label.text = "Box Office"
        label.font = Constants.Fonts.plusJacartaSansBold(with: 16)
        label.textColor = UIColor(named: "Onboarding")
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
        view.backgroundColor = UIColor(named: "BgColor")
        setupMovieCards()
        setupNavigationTitle()
        setupCategories()
        setupHorizontalStack()
        setupMoviesList()
    }

}

// MARK: - ADDING METHODS

extension HomeViewControllerSecond {
    
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
            movieCards.heightAnchor.constraint(equalToConstant: 250),
            
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
        
        NSLayoutConstraint.activate([
            movieCards.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            movieCards.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            movieCards.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieCards.heightAnchor.constraint(equalToConstant: 250)
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
            label.textColor = UIColor(named: "BgColor")
            
            return label
        }()
        
        let description: UILabel = {
            let label = UILabel()
            label.text = "Only stream movie lovers"
            label.font = Constants.Fonts.plusJacartaSansMedium(with: 12)
            label.textColor = UIColor(named: "BgColor")
            
            return label
        }()
        
        lazy var verticalStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [greeting, description])
            stack.axis = .vertical
            stack.spacing = 10
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

extension HomeViewControllerSecond {
    
    @objc private func seeAllTapped() {
        
    }
    
}
