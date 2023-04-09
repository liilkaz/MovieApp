//
//  CategoriesCell.swift
//  MovieApp
//
//  Created by Нахид Гаджалиев on 07.04.2023.
//

import UIKit

class CategoriesCell: UICollectionViewCell {
    
    static let identifier = "CategoriesCell"
    
    let categoryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = Constants.Fonts.plusJacartaSansRegular(with: 12)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 18
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(categoryButton)

        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryButton.heightAnchor.constraint(equalToConstant: contentView.frame.height),
            categoryButton.widthAnchor.constraint(equalToConstant: contentView.frame.width)
        ])
    }
    
}
