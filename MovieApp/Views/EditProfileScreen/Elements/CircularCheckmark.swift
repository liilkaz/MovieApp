//
//  CircularCheckmark.swift
//  MovieApp
//
//  Created by Иван Осипов on 12.04.2023.
//

import UIKit

class CircularCheckmark: UIView {

    private var isChecked = false
    
    let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "checkmark.circle.fill") ?? UIImage(), contentMode: .scaleAspectFit)
        imageView.tintColor = Constants.Colors.splashBackground
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    override func layoutSubviews() {
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.secondaryLabel.cgColor
        layer.cornerRadius = frame.size.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
    
    func toggle() {
        self.isChecked = !isChecked
        if self.isChecked {
            imageView.isHidden = false
        } else {
            imageView.isHidden = true
        }
    }
}

private extension CircularCheckmark {
    
    func setupView() {
        addSubview(imageView)
        backgroundColor = .systemBackground
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
