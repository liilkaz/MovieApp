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
            self.layer.borderColor = Constants.Colors.splashBackground?.cgColor
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

    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: amount,
                                               height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: amount,
                                               height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }

}

// MARK: - Set Icon

extension UITextField {
    
    convenience init(backgroundColor: UIColor,
                     cornerRadius: CGFloat,
                     placeholder: String,
                     minimumFontSize: CGFloat,
                     tintColor: UIColor?,
                     borderWidth: CGFloat,
                     borderColor: CGColor) {
        self.init()
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.placeholder = placeholder
        self.minimumFontSize = minimumFontSize
        self.tintColor = tintColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor
        self.borderStyle = .roundedRect
        self.layer.borderWidth = borderWidth
        self.textColor = Constants.Colors.mainTextColor
        self.font = Constants.Fonts.plusJacartaSansMedium(with: 16)
    }
    
    func setLeftIcon(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 16, y: 0, width: 18, height: 18))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        iconContainerView.addSubview(iconView)
        self.leftView = iconContainerView
        self.leftViewMode = .always
    }
    
    func setRightIcon(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: -42, y: 0, width: 4, height: 18))
        iconView.image = image.withTintColor(Constants.Colors.inactive)
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 20))
        iconContainerView.addSubview(iconView)
        self.rightView = iconContainerView
        self.rightViewMode = .always
    }
}
