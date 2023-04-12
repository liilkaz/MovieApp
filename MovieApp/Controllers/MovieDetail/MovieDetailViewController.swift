//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 07.04.2023.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {
    
    var dataS: UICollectionViewDiffableDataSource<Section, Int>! = nil
    var collectionView: UICollectionView! = nil
    private lazy var mainRange: ClosedRange<Int> = 1...1
    private lazy var scrollRange: ClosedRange<Int> = (mainRange.upperBound + 1)...(mainRange.upperBound + scroll.count)

    private var main: DetailedMovie?
    private var scroll: [CastAndCrewInfo] = CastAndCrewInfo.testData()
    
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
        return UIBarButtonItem(image: UIImage(named: "arrowBack")?.withRenderingMode(.alwaysOriginal),
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
        setupView()
        setConstraints()
        setupNavBar()
        configureHierarchy()
        configureDataSource()
    }
    
    func setupView() {
        view.backgroundColor = UIColor(named: "BgColor")
        title = "Movie Detail"
    
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomView)
        bottomView.backgroundColor = .white
        bottomView.addSubview(bottomButton)
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
       let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(800))
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
               APICaller.shared.getDetailedMovie(with: 585511) { [weak self] result in
                   switch result {
                   case .success(let movie):
                       self?.main = movie
                       DispatchQueue.main.async { [self] in
                           print(self?.main ??  "where is movie")
                           
                           cell.stack.movieName.text = main?.title
                           cell.stack.overview.text = main?.overview

                           //                cell.stack.getRating(percent: mainS.rating)
                       }
                   case .failure(let error):
                       print(error.localizedDescription)
                   }
               }

               return cell
           }
           
           if self.scrollRange ~= identifier {
               guard let cell = collectionView.dequeueReusableCell(
                   withReuseIdentifier: CastAndCrewCollectionViewCell.reuseId,
                   for: indexPath) as? CastAndCrewCollectionViewCell else {fatalError("Cannot create the cell")}
               let scrollS = self.scroll[indexPath.row]
               cell.avatar.image = scrollS.avatar
               cell.name.text = scrollS.name
               cell.role.text = scrollS.prof
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
}
