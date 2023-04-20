//
//  SectionHeader.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 20.04.2023.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    
    static let identifier = "SectionHeader"
    
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupElements(){
        title.textColor = Constants.Colors.mainTextColor
        title.font = Constants.Fonts.plusJacartaSansSemiBold(with: 16)
        title.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints(){
        addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
