//
//  UIImageView + Extension.swift
//  MovieApp
//
//  Created by Djinsolobzik on 03.04.2023.
//

import UIKit

extension UIImageView {
    convenience init(image: UIImage, contentMode: ContentMode) {
        self.init()
        self.image = image
        self.contentMode = contentMode
    }
}
