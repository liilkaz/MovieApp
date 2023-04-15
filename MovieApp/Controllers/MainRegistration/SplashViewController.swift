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

    private lazy var activityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Loading")
        return imageView
    }()

// MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityImageView.startAnimationLoading()
        moviesArray.getAllMovies { [weak self] in
            self?.activityImageView.stopAnimationLoading()
            self?.moveToLogin()
        }
    }

    private func moveToLogin() {
        let loginVC = LoginViewController()
        let navigationController = UINavigationController(rootViewController: loginVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
}

// MARK: - Private Methods

private extension SplashViewController {

    func setLayout() {
        
        view.backgroundColor = Constants.Colors.splashBackground

        view.addSubviews(splashImageView, splashText, activityImageView) {[

            splashImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            splashImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            splashImageView.widthAnchor.constraint(equalToConstant: 150),
            splashImageView.heightAnchor.constraint(equalToConstant: 150),

            splashText.topAnchor.constraint(equalTo: splashImageView.bottomAnchor, constant: 32),
            splashText.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            activityImageView.widthAnchor.constraint(equalToConstant: 80),
            activityImageView.heightAnchor.constraint(equalToConstant: 80),
            activityImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityImageView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -40)

        ]}
    }
}
