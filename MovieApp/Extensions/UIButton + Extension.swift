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
        backgroundColor: UIColor?,
        titleColor: UIColor,
        font: UIFont? = Constants.Fonts.plusJacartaSansSemiBold(with: 16),
        hasBorder: Bool,
        cornerRadius: CGFloat = 4) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.titleLabel?.font = font
        
        self.layer.cornerRadius = cornerRadius
        
        if hasBorder {
            self.layer.borderWidth = 0.3
            self.layer.borderColor = UIColor(named: "Onboarding")?.cgColor
        }
    }
    
    func setupGoogleImage() {
        let image = UIImageView(image: UIImage(named: "googleImage") ?? UIImage(), contentMode: .scaleAspectFit)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 48),
            image.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
    }
    
    func setupImage(_ image: UIImage?) {
        let image = UIImageView(image: image ?? UIImage(), contentMode: .scaleAspectFit)
        image.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(image)

        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            image.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
