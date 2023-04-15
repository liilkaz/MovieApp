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

    // MARK: - Activity Indicator

    func startAnimationLoading() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        self.isHidden = false
        rotation.fromValue = 0
        rotation.toValue = 2 * Double.pi
        rotation.duration = 0.7
        rotation.repeatCount = 100
        rotation.isRemovedOnCompletion = false
        layer.add(rotation, forKey: "spin")
        rotation.isRemovedOnCompletion = false
    }

    func stopAnimationLoading() {
        self.isHidden = true
        layer.removeAllAnimations()
    }
}
