//
//  TopCell.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 23.04.2023.
//

import UIKit
import Gemini

class TopCell: UICollectionViewCell {
    
    static let identifier = "TopCell"
    var movies = [Movie]()
    
    let newView = UIView()
    
    let customPageControl = CustomPageControl(pages: 3)
    
    let geminiCollectionView: GeminiCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let geminiCollectionView = GeminiCollectionView(frame: .zero, collectionViewLayout: layout)
        geminiCollectionView.translatesAutoresizingMaskIntoConstraints = false
        geminiCollectionView.showsHorizontalScrollIndicator = false
        geminiCollectionView.contentInsetAdjustmentBehavior = .never
        geminiCollectionView.backgroundColor = .clear
        geminiCollectionView.register(MovieCardsCell.self, forCellWithReuseIdentifier: MovieCardsCell.identifier)
        
        return geminiCollectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(newView)
        newView.addSubview(geminiCollectionView)
        newView.addSubview(customPageControl)
        
        setupConstraints()
        setupAnimation()
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate) {
        geminiCollectionView.delegate = dataSourceDelegate
        geminiCollectionView.dataSource = dataSourceDelegate
        geminiCollectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func scrollPageControl(indexPath: Int, pagesCount: Int) {
//        print("pageCount:\(pagesCount)")
//        print("IndexPath:\(indexPath)")
//            if indexPath < pagesCount {
//                customPageControl.pageControlTapped(indexPath)
//            } else if indexPath < pagesCount * 2 {
//                customPageControl.pageControlTapped(indexPath - pagesCount - 1)
//            } else {
//                customPageControl.pageControlTapped((indexPath - pagesCount * 2) - 1)
//            }
//    }
    
    func setupAnimation() {
        geminiCollectionView.gemini
            .circleRotationAnimation()
            .radius(1300)
            .rotateDirection(.anticlockwise)
            .itemRotationEnabled(true)
    }
    
    func configure(movies: [Movie]) {
        self.movies = movies
        self.geminiCollectionView.reloadData()
    }
    
    private func setupConstraints() {
        newView.translatesAutoresizingMaskIntoConstraints = false
        customPageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            newView.bottomAnchor.constraint(equalTo: bottomAnchor),
            newView.heightAnchor.constraint(equalToConstant: 400),
            
            geminiCollectionView.leadingAnchor.constraint(equalTo: newView.leadingAnchor),
            geminiCollectionView.trailingAnchor.constraint(equalTo: newView.trailingAnchor),
            geminiCollectionView.topAnchor.constraint(equalTo: newView.topAnchor),
//            geminiCollectionView.bottomAnchor.constraint(equalTo: newView.bottomAnchor)
            geminiCollectionView.heightAnchor.constraint(equalToConstant: 320),
            
            customPageControl.topAnchor.constraint(equalTo: geminiCollectionView.bottomAnchor, constant: 10),
            customPageControl.centerXAnchor.constraint(equalTo: newView.centerXAnchor),
            customPageControl.heightAnchor.constraint(equalToConstant: 35),
            customPageControl.widthAnchor.constraint(equalTo: newView.widthAnchor, multiplier: 0.5, constant: 0)
        ])
    }
}
