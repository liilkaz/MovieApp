//
//  CastAndCrewCollectionViewCell.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 07.04.2023.
//

import UIKit

class CastAndCrewCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "cell"
    
    lazy var avatar: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
//        image.layer.cornerRadius = frame.height / 2
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.plusJacartaSansSemiBold(with: 14)
        label.textColor = Constants.Colors.mainTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let role: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.plusJacartaSansMedium(with: 10)
        label.textColor = Constants.Colors.otherTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
        avatar.layer.cornerRadius = frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(avatar)
        addSubview(name)
        addSubview(role)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            avatar.heightAnchor.constraint(equalToConstant: 40),
            avatar.widthAnchor.constraint(equalToConstant: 40),
            avatar.topAnchor.constraint(equalTo: topAnchor),
            avatar.bottomAnchor.constraint(equalTo: bottomAnchor),
            avatar.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            name.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            name.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 8),
            name.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            role.topAnchor.constraint(equalTo: name.bottomAnchor),
            role.bottomAnchor.constraint(equalTo: bottomAnchor),
            role.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 8),
            role.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
