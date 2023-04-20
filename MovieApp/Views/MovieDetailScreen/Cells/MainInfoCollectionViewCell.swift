//
//  MainInfoCollectionViewCell.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 07.04.2023.
//

import UIKit

class MainInfoCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "mainCell"
    
    let stack = MainInfoStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(stack)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
}
