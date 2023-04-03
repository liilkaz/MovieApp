//
//  UITextField + Extension.swift
//  MovieApp
//
//  Created by Djinsolobzik on 03.04.2023.
//

import UIKit

extension UITextField {

    convenience init(hasBorder: Bool, backgroundColor: UIColor?, cornerRadius: CGFloat, placeholder: String) {
        self.init()
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = self.bounds.width / 2
        self.placeholder = placeholder

        if hasBorder {
            self.layer.borderWidth = 0.3
            self.layer.borderColor = K.Colors.splashBackground?.cgColor
        }
    }

    func setupRightButton(with image: UIImage) {
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(button)

        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            button.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

// MARK: - Padding for textContent

extension UITextField {

    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}


