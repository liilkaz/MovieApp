//
//  SplashViewController.swift
//  MovieApp
//
//  Created by Djinsolobzik on 03.04.2023.
//

import UIKit

final class SplashViewController: UIViewController {
    
    private let moviesArray = AllMovies.shared

    // MARK: - Private Properties

    private lazy var splashImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "splashPlay") ?? UIImage(), contentMode: .scaleAspectFill)
        return imageView
    }()

    private lazy var splashText: UILabel = {
        let label = UILabel(name: "Moviemax", font: UIFont.jakarta32())
        label.textColor = .white
        return label
    }()

// MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        moviesArray.getAllMovies()
    }
}

// MARK: - Private Methods

private extension SplashViewController {

    func setLayout() {
        
        view.backgroundColor = Constants.Colors.splashBackground

        view.addSubviews(splashImageView, splashText) {[

            splashImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            splashImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            splashImageView.widthAnchor.constraint(equalToConstant: 150),
            splashImageView.heightAnchor.constraint(equalToConstant: 150),

            splashText.topAnchor.constraint(equalTo: splashImageView.bottomAnchor, constant: 32),
            splashText.centerXAnchor.constraint(equalTo: view.centerXAnchor)

        ]}
    }
}
