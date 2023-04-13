//
//  CategoryCollectionView.swift
//  MovieApp
//
//  Created by Нахид Гаджалиев on 07.04.2023.
//

import UIKit

class CategoryCollectionView: UICollectionView {
    
    var categories: [FilmCategories] = [.all, .action, .adventure, .mystery, .fantasy, .comedy, .crime, .other]
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        delegate = self
        dataSource = self
        register(CategoriesCell.self,
                 forCellWithReuseIdentifier: CategoriesCell.identifier)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(named: "BgColor")
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CategoryCollectionView: UICollectionViewDelegate {
    
}

extension CategoryCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: CategoriesCell.identifier,
                                             for: indexPath) as? CategoriesCell
        else {
            return UICollectionViewCell()
        }
        cell.categoryButton.setTitle(categories[indexPath.row].movieCategories, for: .normal)
        return cell
    }
}
extension CategoryCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 88, height: collectionView.frame.height)
    }
}
