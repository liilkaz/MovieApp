//
//  MovieCardsCell.swift
//  MovieApp
//
//  Created by Нахид Гаджалиев on 06.04.2023.
//

import UIKit

class MovieCardsCell: UICollectionViewCell {
    
    static let identifier = "MoviesCell"
    
    lazy var picture: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var filmName: UILabel = {
        let label = UILabel()
        label.text = "Thor"
        label.font = Constants.Fonts.plusJacartaSansBold(with: 14)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var category: UILabel = {
        let label = UILabel()
        label.text = "Action"
        label.font = Constants.Fonts.plusJacartaSansMedium(with: 10)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.backgroundColor = .gray.withAlphaComponent(0.2)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(picture)
        picture.layer.cornerRadius = 16
        picture.addSubview(category)
        picture.addSubview(filmName)
  
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            picture.heightAnchor.constraint(equalToConstant: contentView.frame.height),
            picture.widthAnchor.constraint(equalToConstant: contentView.frame.width),

            category.leadingAnchor.constraint(equalTo: picture.leadingAnchor, constant: 10),
            category.bottomAnchor.constraint(equalTo: filmName.topAnchor, constant: -10),
            category.heightAnchor.constraint(equalToConstant: category.intrinsicContentSize.height + 10),
            category.widthAnchor.constraint(equalToConstant: category.intrinsicContentSize.width + 10),
            
            filmName.leadingAnchor.constraint(equalTo: picture.leadingAnchor, constant: 10),
            filmName.bottomAnchor.constraint(equalTo: picture.bottomAnchor, constant: -10)
        ])
    }
    
}
