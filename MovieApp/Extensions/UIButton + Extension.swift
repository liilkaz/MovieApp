//
//  UIButton + Extension.swift
//  MovieApp
//
//  Created by Djinsolobzik on 03.04.2023.
//

import UIKit

extension UIButton {
    convenience init(
        title: String,
        backgroundCollor: UIColor,
        titleColor: UIColor,
        font: UIFont? = .jakarta16(),
        isShadow: Bool,
        cornerRadius: CGFloat = 4)
    {

        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundCollor
        self.titleLabel?.font = font

        self.layer.cornerRadius = cornerRadius

        if isShadow {
            self.layer.shadowRadius = 4
            self.layer.shadowOpacity = 0.2
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 8)

        }
    }

    func setupGoogleImage() {
        let image = UIImageView(image: UIImage(named: "googleImage") ?? UIImage(), contentMode: .scaleAspectFit)
        image.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(image)

        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            image.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])

    }
}

