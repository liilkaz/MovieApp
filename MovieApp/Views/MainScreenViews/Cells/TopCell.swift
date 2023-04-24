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
        NSLayoutConstraint.activate([
            newView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            newView.bottomAnchor.constraint(equalTo: bottomAnchor),
            newView.heightAnchor.constraint(equalToConstant: 350),
            
            geminiCollectionView.leadingAnchor.constraint(equalTo: newView.leadingAnchor),
            geminiCollectionView.trailingAnchor.constraint(equalTo: newView.trailingAnchor),
            geminiCollectionView.topAnchor.constraint(equalTo: newView.topAnchor),
//            geminiCollectionView.bottomAnchor.constraint(equalTo: newView.bottomAnchor)
            geminiCollectionView.heightAnchor.constraint(equalToConstant: 320)
        ])
    }
}
