//
//  MovieCardsCarusel.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 15.04.2023.
//

import UIKit

class MovieCardsCarusel: UIView {
    
    let movieArray = AllMovies.shared

    // MARK: - Subviews
    
    lazy var carouselCollectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.delegate = self
        collection.register(MovieCardsCell.self, forCellWithReuseIdentifier: MovieCardsCell.identifier)
        collection.backgroundColor = .clear
        return collection
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = pages
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.3925074935, green: 0.3996650577, blue: 0.7650645971, alpha: 1)
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    // MARK: - Properties
    
    private var pages = 3
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
// MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupUI()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setups

private extension MovieCardsCarusel {
    func setupUI() {
        backgroundColor = .clear
        setupCollectionView()
        setupPageControl()
    }
    
    func setupCollectionView() {

        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal

        carouselCollectionView.collectionViewLayout = carouselLayout
        
        addSubview(carouselCollectionView)
        NSLayoutConstraint.activate([
            carouselCollectionView.topAnchor.constraint(equalTo: topAnchor),
            carouselCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            carouselCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            carouselCollectionView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func setupPageControl() {
        addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: carouselCollectionView.bottomAnchor, constant: 10),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.widthAnchor.constraint(equalToConstant: 150),
            pageControl.heightAnchor.constraint(equalToConstant: 50)

        ])
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MovieCardsCarusel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 188, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let cellPadding = (frame.width - 188) / 2
        
        return cellPadding * 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellPadding = (frame.width - 188) / 2
        
        return .init(top: 0, left: cellPadding, bottom: 0, right: cellPadding)
    }
}

// MARK: - UICollectionViewDelegate

extension MovieCardsCarusel: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        currentPage = getCurrentPage()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
}

// MARK: - Helpers

private extension MovieCardsCarusel {
    func getCurrentPage() -> Int {

        let visibleRect = CGRect(origin: carouselCollectionView.contentOffset, size: carouselCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = carouselCollectionView.indexPathForItem(at: visiblePoint) {
            return visibleIndexPath.row
        }
        return currentPage
    }
}
