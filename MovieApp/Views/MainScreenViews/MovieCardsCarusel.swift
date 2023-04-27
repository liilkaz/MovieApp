//
//  MovieCardsCarusel.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 15.04.2023.
//

import UIKit
import Gemini

class MovieCardsCarusel: UIView {
    
    let movieArray = AllMovies.shared
    
    var geminiCollectionView: GeminiCollectionView! = nil
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = pages
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.3925074935, green: 0.3996650577, blue: 0.7650645971, alpha: 1)
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    var pages = 3
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
    func createGeminiLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }
    
    func setupGemniCollectionView() {
        geminiCollectionView = GeminiCollectionView(frame: .zero, collectionViewLayout: createGeminiLayout())
        geminiCollectionView.translatesAutoresizingMaskIntoConstraints = false
        geminiCollectionView.showsHorizontalScrollIndicator = false
        geminiCollectionView.backgroundColor = .clear
        geminiCollectionView.delegate = self
        geminiCollectionView.dataSource = self
        geminiCollectionView.register(MovieCardsCell.self, forCellWithReuseIdentifier: MovieCardsCell.identifier)
        geminiCollectionView.gemini
                        .circleRotationAnimation()
                        .radius(1100)
                        .rotateDirection(.anticlockwise)
                        .itemRotationEnabled(true)
        setupGeminiConstrains()
    }
    
    private func setupGeminiConstrains() {
        addSubview(geminiCollectionView)
        NSLayoutConstraint.activate([
            geminiCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            geminiCollectionView.topAnchor.constraint(equalTo: topAnchor),
            geminiCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            geminiCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(pageControl)
        setupGemniCollectionView()
        setupPageControl()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension MovieCardsCarusel: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieArray.popularMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCardsCell.identifier,
                                                            for: indexPath) as? MovieCardsCell
        else {fatalError("Cannot create the cell")}
        cell.configure(movie: movieArray.popularMovies[indexPath.row])
        self.geminiCollectionView.animateCell(cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            if let cell = cell as? GeminiCell {
                self.geminiCollectionView.animateCell(cell)
            }
    }
}

extension MovieCardsCarusel: UICollectionViewDelegateFlowLayout {
    private enum Const {
        static let collectionViewSize = CGSize(width: 180, height: 250)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Const.collectionViewSize
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        }
        switch layout.scrollDirection {
        case .horizontal:
            let verticalMargin: CGFloat = (collectionView.bounds.height - Const.collectionViewSize.height) / 2
            print("carusel: \(collectionView.bounds.height)")
            return UIEdgeInsets(top: 50 + verticalMargin,
                                left: 50,
                                bottom: 50 + verticalMargin,
                                right: 50)

        case .vertical:
            let horizontalMargin: CGFloat = (collectionView.bounds.width - Const.collectionViewSize.width) / 2
            return UIEdgeInsets(top: 50,
                                left: 50 + horizontalMargin,
                                bottom: 50,
                                right: 50 + horizontalMargin)
        }
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

// MARK: - Setup Page Control

extension MovieCardsCarusel {

    func setupPageControl() {
        backgroundColor = .clear
        addSubview(pageControl)

        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: geminiCollectionView.bottomAnchor),
            pageControl.centerYAnchor.constraint(equalTo: centerYAnchor),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.widthAnchor.constraint(equalToConstant: 150),
            pageControl.heightAnchor.constraint(equalToConstant: 50)

        ])

    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        currentPage = getCurrentPage()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.geminiCollectionView.animateVisibleCells()
        currentPage = getCurrentPage()
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
}

// MARK: - Helpers

private extension MovieCardsCarusel {
    func getCurrentPage() -> Int {

        let visibleRect = CGRect(origin: geminiCollectionView.contentOffset, size: geminiCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = geminiCollectionView.indexPathForItem(at: visiblePoint) {
            return visibleIndexPath.row
        }
        return currentPage
    }
}
