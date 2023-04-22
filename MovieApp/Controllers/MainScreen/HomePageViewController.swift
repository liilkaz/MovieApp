//
//  HomePageViewController.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 19.04.2023.
//

import UIKit

class HomePageViewController: UIViewController, UICollectionViewDelegate {
    
    let movieArray = AllMovies.shared
    var moviesByGenre = [Movie]()
    let movieCarousel = MovieCardsCarusel()
    
    private let userDataSource = UserDataSource()
    private var userModel: UserModel?
    private func getUserModel() {
        userModel = UserDataSource().getUser(for: AllMovies.shared.userId)
    }
    
    var categories: [FilmCategories] = [.all, .action, .adventure, .mystery, .fantasy, .comedy, .crime]
    
    var collectionView: UICollectionView! = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesByGenre = movieArray.allMovies
        getUserModel()
        setupNavigationTitle()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
       collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCardsCell.self, forCellWithReuseIdentifier: MovieCardsCell.identifier)
        collectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesCell.identifier)
        collectionView.register(AllMoviesViewCell.self, forCellWithReuseIdentifier: AllMoviesViewCell.identifier)
        view.addSubview(collectionView)
        
        collectionView.register(SectionHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeader.identifier)
        setupConstrains()
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
       }
}

extension HomePageViewController {
    
    private func setupNavigationTitle() {
        
        let image: UIImageView = {
            let img = UIImageView()
            img.image = UIImage(named: "profileIcon")
            
            return img
        }()
        
        let greeting: UILabel = {
            let label = UILabel()
            
            label.text = "Hi, \(userModel?.firstName ?? "NO")"
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

extension HomePageViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return movieArray.popularMovies.count
        case 1:
            return categories.count
        default:
            return moviesByGenre.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCardsCell.identifier,
                                                                for: indexPath) as? MovieCardsCell
            else {fatalError("Cannot create the cell")}
            cell.picture.sd_setImage(with: movieArray.popularMovies[indexPath.row].urlImage)
            cell.filmName.text = movieArray.popularMovies[indexPath.row].title
//                    cell.category.text = movieArray.popularMovies[indexPath.row].genre_ids
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.identifier,
                                                                for: indexPath) as? CategoriesCell
            else {fatalError("Cannot create the cell")}
            cell.categoryButton.setTitle(categories[indexPath.row].movieCategories, for: .normal)
            if indexPath.row == 0 {
                DispatchQueue.main.async {
                    cell.isSelected = true
                }
            }
            return cell
            
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllMoviesViewCell.identifier,
                                                                for: indexPath) as? AllMoviesViewCell else {fatalError("Cannot create the cell")}
            let isFavorite = userDataSource.isFavorites(for: AllMovies.shared.userId, with: moviesByGenre[indexPath.row].id)
            cell.configure(url: moviesByGenre[indexPath.row].urlImage,
                           movieName: moviesByGenre[indexPath.row].title,
//                           duration: moviesByGenre[indexPath.row].,
                           rating: "\(moviesByGenre[indexPath.row].vote_average)",
                           vote_count: "(\(moviesByGenre[indexPath.row].vote_count))", movieId: self.moviesByGenre[indexPath.row].id, isFavorite: isFavorite)
            
//            cell.didTapedFavoriteButton = { [weak self] in
//                guard let self else { return }
//                if cell.isFavorite {
//                    self.userDataSource.saveFavorite(with: self.moviesByGenre[indexPath.row].id, in: AllMovies.shared.userId)
//                } else {
//                    self.userDataSource.deleteFavorite(for: AllMovies.shared.userId, movieId: Int64(self.moviesByGenre[indexPath.row].id))
//                }
//            }
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
            switch indexPath.section {
            case 0:
                return UICollectionReusableView()
            case 1:
                guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: SectionHeader.identifier,
                    for: indexPath) as? SectionHeader else {return UICollectionReusableView()}
                sectionHeader.title.text = "Categories"
                return sectionHeader
            default:
                guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: SectionHeader.identifier,
                    for: indexPath) as? SectionHeader else {return UICollectionReusableView()}
                sectionHeader.title.text = "Box Office"
                return sectionHeader
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let detailScreen = MovieDetailViewController()
            let movie = movieArray.popularMovies[indexPath.row]
            userDataSource.saveRecent(with: movie.id, in: AllMovies.shared.userId)
            detailScreen.id = movie.id
            navigationController?.pushViewController(detailScreen, animated: true)
        case 1:
            let genre = categories[indexPath.row].rawValue
            if genre == 0 {
                moviesByGenre = movieArray.allMovies
                } else {
                    moviesByGenre = movieArray.allMovies.filter({ $0.genre_ids[0] == genre
                    })
                }
            collectionView.reloadSections(IndexSet(integer: 2))
        default:
            let detailScreen = MovieDetailViewController()
            let movie = moviesByGenre[indexPath.row]
            userDataSource.saveRecent(with: movie.id, in: AllMovies.shared.userId)
            detailScreen.id = movie.id
            navigationController?.pushViewController(detailScreen, animated: true)
        }
    }
}

extension HomePageViewController: UICollectionViewDelegateFlowLayout {
    
    enum Section: Int, CaseIterable {
        case mainCarusel
        case categories
        case table

        var columnCount: Int {
            switch self {
            case .mainCarusel:
                return 0
            case .categories:
                return 1
            case .table:
                return 2
            }
        }
    }
    
    func createLayout() -> UICollectionViewLayout {
        let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            let section = self.layoutSection(for: sectionKind, layoutEnvironment: layoutEnvironment)
            return section
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 16.0
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        return layout
    }
    
    func layoutSection(for section: Section, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        switch section {
        case .mainCarusel:
            return mainCaruselSection()
        case .categories:
            return categoriesSection()
        case .table:
            return self.tableSection()
        }
    }

    private func mainCaruselSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(180), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250))
         let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        group.interItemSpacing = .fixed(20)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0)
        return section
    }
    
    private func categoriesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(88),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(34))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        group.interItemSpacing = .fixed(12)
        let section = NSCollectionLayoutSection(group: group)

        section.orthogonalScrollingBehavior = .paging
        section.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                        leading: 23,
                                                        bottom: 0,
                                                        trailing: 0)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func tableSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.9))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(95))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 23, bottom: 0, trailing: 24)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
}
