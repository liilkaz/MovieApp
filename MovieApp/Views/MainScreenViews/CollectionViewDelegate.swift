//
//  CollectionViewDelegate.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 24.04.2023.
//

import UIKit
import Gemini

class CollectionViewDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var movies = [Movie]()
    let topCell = TopCell()
    
    var didTappedCell: ((_ id: Int) -> Void)?
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let gemini = scrollView as? GeminiCollectionView {
            gemini.animateVisibleCells()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCardsCell.identifier,
                                                                   for: indexPath) as? MovieCardsCell
        else {fatalError("Cannot create the cell")}
        
        cell.configure(movie: movies[indexPath.row])
        topCell.geminiCollectionView.animateCell(cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailScreen = MovieDetailViewController()
        let movie = movies[indexPath.row]
        
        print(movie.title)
//        detailScreen.id = movie.id
//        detailScreen.show(detailScreen, sender: self)
//        let currentController = self.getCurrentViewController()
//        currentController?.navigationController?.pushViewController(detailScreen, animated: true)
//        currentController?.present(detailScreen, animated: true, completion: nil)
        
        didTappedCell?(movie.id)
        
    }
    
    func getCurrentViewController() -> UIViewController? {
        let currentViewController = HomePageViewController()
//        currentViewController.navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
//        if let rootController = UIApplication.shared.UIApplication.shared.keyWindow?.rootViewController {
//            var currentController: UIViewController! = rootController.navigationController
//            while(currentController.presentedViewController != nil) {
//                currentController = currentController.presentedViewController
//            }
            return currentViewController
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCardsCell.identifier,
                                                                   for: indexPath) as? MovieCardsCell
        else {fatalError("Cannot create the cell")}
        topCell.geminiCollectionView.animateCell(cell)
        topCell.geminiCollectionView.reloadData()
    }
    
    private enum Const {
            static let collectionViewSize = CGSize(width: 180, height: 250)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Const.collectionViewSize
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let verticalMargin: CGFloat = (collectionView.bounds.height - Const.collectionViewSize.height) / 2
//        print(collectionView.bounds.height)
        return UIEdgeInsets(top: 50 + verticalMargin,
                            left: 50,
                            bottom: 50 + verticalMargin,
                            right: 50)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
