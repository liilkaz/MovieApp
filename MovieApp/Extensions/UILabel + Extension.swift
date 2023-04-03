//
//  UILabel + Extension.swift
//  MovieApp
//
//  Created by Djinsolobzik on 03.04.2023.
//

import UIKit

extension UILabel {
    convenience init(name: String, font: UIFont? = .jakarta16()) {
        self.init()
        self.text = name
        self.font = font
    }
}

