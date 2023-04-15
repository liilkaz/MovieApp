//
//  UIImage + Extension.swift
//  MovieApp
//
//  Created by Иван Осипов on 15.04.2023.
//

import UIKit

extension UIImage {
    func circle() -> UIImage {
        let imageSize = CGSize(width: 100, height: 100)
        let circleImage = UIGraphicsImageRenderer(size: imageSize).image { _ in
            let imageFrame = CGRect(
                origin: .zero,
                size: imageSize
            )
            let circle = UIBezierPath(ovalIn: imageFrame)
            circle.addClip()
            self.draw(in: imageFrame)
        }
        return circleImage
    }
}
