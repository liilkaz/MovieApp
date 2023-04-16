//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 07.04.2023.
//

import UIKit
import SDWebImage
import SafariServices

class MovieDetailViewController: UIViewController, UICollectionViewDelegate, SFSafariViewControllerDelegate {
    
    var dataS: UICollectionViewDiffableDataSource<Section, Int>! = nil
    var collectionView: UICollectionView! = nil
    private lazy var mainRange: ClosedRange<Int> = 1...1
    private lazy var scrollRange: ClosedRange<Int> = (mainRange.upperBound + 1)...(mainRange.upperBound + (castAndCrew?.cast.count ?? 10))
    
    var id: Int?
    var ratingStars = [UIImageView](repeating: UIImageView(), count: 5)
    var rating: Rating?
    
    var trailers: [YouTubeTrailer]?
    private var movie: DetailedMovie?
    private var castAndCrew: Credits?
    
    let bottomView = UIView()
    
    let bottomButton: UIButton = {
        let button = UIButton(title: "Whatch now", backgroundColor: Constants.Colors.active, titleColor: .white, hasBorder: false)
        button.layer.cornerRadius = 24
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var addBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(systemName: "heart"),
                               style: .plain,
                               target: self,
                               action: #selector(addToFavorites))
        }()
    
    private lazy var addBarButtonBack: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(named: "arrowBack")?.withRenderingMode(.alwaysOriginal).withTintColor(.label),
                               style: .plain,
                        
                               target: self,
                               action: #selector(back))
    }()
    
    @objc func addToFavorites() {}

    @objc func back() {
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getDetail()
//        getCredits()
        getTrailerMovie()
        setupView()
        setConstraints()
        setupNavBar()
        configureHierarchy()
        configureDataSource()
        collectionView.delegate = self
    }
    
    func setupView() {
        view.backgroundColor = UIColor(named: "BgColor")
        title = "Movie Detail"
    
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomView)
        bottomView.backgroundColor = UIColor(named: "BgColor")
        bottomView.addSubview(bottomButton)
        bottomButton.addTarget(self, action: #selector(whachNowTapped), for: .touchUpInside)
    }
    
    @objc func whachNowTapped() {
        if trailers != nil {showSafariVC(for: trailers?[0].youtubeURL ?? "")}
    }
    
    func showSafariVC(for url: String) {
        guard let url = URL(string: url) else {
        return }
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
        present(safariVC, animated: true)
    }
    
    func setupNavBar() {
        navigationItem.rightBarButtonItem = addBarButtonItem
        navigationItem.leftBarButtonItem = addBarButtonBack
        tabBarController?.tabBar.isHidden = true
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 100),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            bottomButton.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            bottomButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            bottomButton.heightAnchor.constraint(equalToConstant: 56),
            bottomButton.widthAnchor.constraint(equalToConstant: 181)
        ])
    }
}

extension MovieDetailViewController {
    
    enum Section: Int, CaseIterable {
        case main
        case scroll
        
        var columnCount: Int {
            switch self {
            case .main:
                return 1
            case .scroll:
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
        case .main:
            return mainSection()
        case .scroll:
            return scrollSection()
        }
    }
    
    private func mainSection() -> NSCollectionLayoutSection {
       let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(630))
       let item = NSCollectionLayoutItem(layoutSize: itemSize)
       
       let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(630))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
       
       let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .groupPaging
       return section
   }
   
    private func scrollSection() -> NSCollectionLayoutSection {
       let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(40))
       let item = NSCollectionLayoutItem(layoutSize: itemSize)
       
       let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
       let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
       
       let rootGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(40))
       let rootGroup = NSCollectionLayoutGroup.horizontal(layoutSize: rootGroupSize, subitems: [group])
       let section = NSCollectionLayoutSection(group: rootGroup)
       section.interGroupSpacing = 21
       section.orthogonalScrollingBehavior = .continuous
       return section
   }
   
    func configureHierarchy() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
       collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
       let castAndCrewCell = CastAndCrewCollectionViewCell.self
       collectionView.register(castAndCrewCell, forCellWithReuseIdentifier: castAndCrewCell.reuseId)
       let mainInfoCell = MainInfoCollectionViewCell.self
       collectionView.register(mainInfoCell, forCellWithReuseIdentifier: mainInfoCell.reuseId)
       
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomView.topAnchor)
        ])
   }

    func configureDataSource() {
       dataS = UICollectionViewDiffableDataSource<Section, Int>(
        collectionView: collectionView) { [self](collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
           if self.mainRange ~= identifier {
               guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainInfoCollectionViewCell.reuseId,
                                                                   for: indexPath) as? MainInfoCollectionViewCell else { fatalError("Cannot create the cell") }
               cell.stack.poster.sd_setImage(with: movie?.urlImage)
               cell.stack.movieName.text = movie?.title
               cell.stack.overview.text = movie?.overview
               cell.stack.dateStack.label.text = movie?.textDate
               cell.stack.timeStack.label.text = "\(movie?.runtime ?? 0) minutes"
               cell.stack.genreStack.label.text = movie?.genres[0].name
               let vote_average = movie?.vote_average
               if vote_average ?? 0 > 0 {
                   rating = getRating(percent: Int((vote_average ?? 2) * 10))
                   ratingStars = getArrayStars(rating: self.rating ?? .one)
                   ratingStars.forEach( cell.stack.self.hStackReating.addArrangedSubview)
               }
               return cell
           }
           
           if self.scrollRange ~= identifier {
               guard let cell = collectionView.dequeueReusableCell(
                   withReuseIdentifier: CastAndCrewCollectionViewCell.reuseId,
                   for: indexPath) as? CastAndCrewCollectionViewCell else {fatalError("Cannot create the cell")}
               cell.avatar.sd_setImage(with: castAndCrew?.cast[indexPath.row].urlImage)
               cell.name.text = castAndCrew?.cast[indexPath.row].name
               cell.role.text = castAndCrew?.cast[indexPath.row].character
               return cell
           }
           fatalError("Cannot create the cell")
           
       }
       
       var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
       let sections: [Section] = [.main, .scroll]
       snapshot.appendSections([sections[0]])
       snapshot.appendItems(Array(mainRange))
       snapshot.appendSections([sections[1]])
       snapshot.appendItems(Array(scrollRange))

       dataS.apply(snapshot, animatingDifferences: false)
       
       }
    
    func getDetail() {
        APICaller.shared.getDetailedMovie(with: id ?? 585511) { [weak self] result in
            switch result {
            case .success(let movie):
                DispatchQueue.main.async { [self] in
                    self?.movie = movie
                    self?.getCredits()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getCredits() {
        APICaller.shared.getCredits(with: id ?? 585511) { [weak self] result in
            switch result {
            case .success(let credits):
                DispatchQueue.main.async { [self] in
                    self?.castAndCrew = credits
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func getTrailerMovie() {
        APICaller.shared.getTrailer(with: id ?? 585511) { [weak self] result in
            switch result {
            case .success(let trailers):
                DispatchQueue.main.async {
                    self?.trailers = trailers
                }
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    func getRating(percent: Int) -> Rating {
        if percent > 80 {
            return Rating.five
        } else if percent > 60 {
            return Rating.four
        } else if percent > 40 {
            return Rating.three
        } else if percent > 20 {
            return Rating.two
        } else {
            return Rating.one
        }
    }
    
    func getArrayStars(rating: Rating) -> [UIImageView] {
        var stars = [UIImageView](repeating: UIImageView(), count: 5)
        let image = UIImage(named: "star") ?? UIImage()
        let color = UIColor(red: 0.98, green: 0.80, blue: 0.08, alpha: 1.00)
        switch rating {
        case .five:
            for _ in 1...stars.count {
                stars.append(UIImageView(image: image.withTintColor(color)))
            }
            return stars
        case .four:
            for _ in 1...4 {
                stars.append(UIImageView(image: image.withTintColor(color)))
            }
            stars.append(UIImageView(image: image))
            return stars
        case .three:
            for _ in 1...3 {
                stars.append(UIImageView(image: image.withTintColor(color)))
            }
            for _ in 1...2 {
                stars.append(UIImageView(image: image))
            }
            return stars
        case .two:
            for _ in 1...2 {
                stars.append(UIImageView(image: image.withTintColor(color)))
            }
            for _ in 1...3 {
                stars.append(UIImageView(image: image))
            }
            return stars
        case .one:
            stars.append(UIImageView(image: image.withTintColor(color)))
            for _ in 1...4 {
                stars.append(UIImageView(image: image))
            }
            return stars
        }
    }
}
