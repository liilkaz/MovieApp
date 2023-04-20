//
//  OverviewCollectionViewCell.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 20.04.2023.
//

import UIKit

class OverviewCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "overviewCell"
    
    let overview: ExpandableLabel = {
        let label = ExpandableLabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = Constants.Fonts.plusJacartaSansMedium(with: 14)
        label.textColor = Constants.Colors.otherTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(overview)
    
        contentMode = .center
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            overview.topAnchor.constraint(equalTo: contentView.topAnchor),
            overview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            overview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            overview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
