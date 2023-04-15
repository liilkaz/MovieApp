//
//  MovieCardsCollectionView.swift
//  MovieApp
//
//  Created by Нахид Гаджалиев on 06.04.2023.
//

import UIKit

class MovieCardsCollectionView: UICollectionView {
    
    let movieArray = AllMovies.shared
    
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
        movieArray.popularMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: MovieCardsCell.identifier,
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

extension MovieCardsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 188, height: collectionView.frame.height)
    }
}
