//
//  UIView + Extension.swift
//  MovieApp
//
//  Created by Djinsolobzik on 03.04.2023.
//

import UIKit

extension UIView {

    func addSubviews(_ views: UIView..., priority: Float? = nil, constraints: () -> ([NSLayoutConstraint])) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        let constraints = constraints()
        if let priority {
            constraints.forEach { $0.priority = .init(priority) }
        }
        NSLayoutConstraint.activate(constraints)
    }
    
    //MARK: - Activity Indicator

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
