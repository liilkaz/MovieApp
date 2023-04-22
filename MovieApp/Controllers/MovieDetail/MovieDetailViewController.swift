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
    
    var didTapedFavoriteButton: (() -> Void)?
    
    var collectionView: UICollectionView! = nil
    private var movieId: Int?
    
    private let userDataSource = UserDataSource()
    private var userModel: UserModel?
    
    var id: Int?
    var ratingStars = [UIImageView](repeating: UIImageView(), count: 5)
    var rating: Rating?
    
    var trailers: [YouTubeTrailer]?
    private var movie: DetailedMovie?
    private var castAndCrew: Credits?
    
    let bottomView = UIView()
    
    var isFavorite: Bool = false {
        didSet {
            let image = UIImage(named: isFavorite ? "favorite_fill" : "favorite")
            addBarButtonItem.image = image
            addBarButtonItem.tintColor = Constants.Colors.active
        }
    }
    
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
                               action: #selector(didTapLike))
        }()
    
    private lazy var addBarButtonBack: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(named: "arrowBack")?.withRenderingMode(.alwaysOriginal).withTintColor(.label),
                               style: .plain,
                        
                               target: self,
                               action: #selector(back))
    }()
    
    @objc func didTapLike() {
        isFavorite.toggle()
        didTapedFavoriteButton?()
        
        guard let movie = movieId else { return }
        if isFavorite {
            userDataSource.saveFavorite(with: movie, in: AllMovies.shared.userId)
        } else {
            userDataSource.deleteFavorite(for: AllMovies.shared.userId, movieId: Int64(movie))
        }
    }

    @objc func back() {
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getDetail()
        getTrailerMovie()
        setupView()
        setupCollectionView()
        setConstraints()
        setupNavBar()
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
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
       collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainInfoCollectionViewCell.self, forCellWithReuseIdentifier: MainInfoCollectionViewCell.reuseId)
        collectionView.register(OverviewCollectionViewCell.self, forCellWithReuseIdentifier: OverviewCollectionViewCell.reuseId)
        collectionView.register(CastAndCrewCollectionViewCell.self, forCellWithReuseIdentifier: CastAndCrewCollectionViewCell.reuseId)
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
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)])
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

extension MovieDetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return castAndCrew?.cast.count ?? 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainInfoCollectionViewCell.reuseId,
                                                                for: indexPath) as? MainInfoCollectionViewCell else { fatalError("Cannot create the cell") }
            cell.stack.poster.sd_setImage(with: movie?.urlImage)
            cell.stack.movieName.text = movie?.title
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
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: OverviewCollectionViewCell.reuseId,
                for: indexPath) as? OverviewCollectionViewCell else {fatalError("Cannot create the cell")}
            cell.overview.text = movie?.overview
            return cell
            
        default:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CastAndCrewCollectionViewCell.reuseId,
                for: indexPath) as? CastAndCrewCollectionViewCell else {fatalError("Cannot create the cell")}
            cell.avatar.sd_setImage(with: castAndCrew?.cast[indexPath.row].urlImage)
            cell.name.text = castAndCrew?.cast[indexPath.row].name
            cell.role.text = castAndCrew?.cast[indexPath.row].character
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
                sectionHeader.title.text = "Story Line"
                return sectionHeader
            default:
                guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: SectionHeader.identifier,
                    for: indexPath) as? SectionHeader else {return UICollectionReusableView()}
                sectionHeader.title.text = "Cast and Crew"
                return sectionHeader
            }
        }
}

extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    
    enum SectionDetail: Int, CaseIterable {
        case mainInfo
        case overview
        case cast

        var columnCount: Int {
            switch self {
            case .mainInfo:
                return 0
            case .overview:
                return 1
            case .cast:
                return 2
            }
        }
    }
    
    func createLayout() -> UICollectionViewLayout {
        let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionKind = SectionDetail(rawValue: sectionIndex) else { return nil }
            let section = self.layoutSection(for: sectionKind, layoutEnvironment: layoutEnvironment)
            return section
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 24.0
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        return layout
    }
    
    func layoutSection(for section: SectionDetail, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        switch section {
        case .mainInfo:
            return mainInfo()
        case .overview:
            return overview()
        case .cast:
            return cast()
        }
    }

    private func mainInfo() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(440))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(440))
         let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)

//        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 42, bottom: 24, trailing: 41)
        
        return section
    }
    
    private func overview() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(
                    widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
                    heightDimension: NSCollectionLayoutDimension.estimated(80)
                )
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                        leading: 24,
                                                        bottom: 0,
                                                        trailing: 24)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func cast() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(150), heightDimension: .absolute(40))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 21
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 23, bottom: 0, trailing: 0)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
}

extension MovieDetailViewController {
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


