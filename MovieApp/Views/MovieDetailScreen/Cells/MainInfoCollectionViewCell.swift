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
        addSubview(stack)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
