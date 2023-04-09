//
//  MovieCardsCollectionView.swift
//  MovieApp
//
//  Created by Нахид Гаджалиев on 06.04.2023.
//

import UIKit

class MovieCardsCollectionView: UICollectionView {
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        delegate = self
        dataSource = self
        register(MovieCardsCell.self,
                 forCellWithReuseIdentifier: MovieCardsCell.identifier)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(named: "BgColor")
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieCardsCollectionView: UICollectionViewDelegate {
}

extension MovieCardsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: MovieCardsCell.identifier,
                                             for: indexPath) as? MovieCardsCell
        else {
            return UICollectionViewCell()
        }
        cell.picture.image = UIImage(named: "movie")
        cell.filmName.text = "Thor"
        cell.category.text = "Action"
        return cell
    }
    
}

extension MovieCardsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 188, height: collectionView.frame.height)
    }
}
