//
//  MoviesCellView.swift
//  MovieApp
//
//  Created by Нахид Гаджалиев on 08.04.2023.
//

import UIKit

class MoviesCellView: UITableViewCell {
    
    static let identifier = "MoviesTableView"
    
    lazy var image: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "secondMovie")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Action"
        label.font = Constants.Fonts.plusJacartaSansMedium(with: 12)
        label.textColor = .lightGray
        label.textAlignment = .left
        return label
    }()
    
    lazy var filmName: UILabel = {
        let label = UILabel()
        label.text = "Film name"
        label.font = Constants.Fonts.plusJacartaSansBold(with: 18)
        label.textAlignment = .left
        return label
    }()

    lazy var clockImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "time")?.withTintColor(Constants.Colors.iconThemeColor ?? UIColor.black))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.frame = CGRect(x: 0, y: 0, width: 13.33, height: 13.33)

        return image
    }()
    
    lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.text = "\(150) Minutes"
        label.textColor = Constants.Colors.mainTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 0, y: 0, width: 74, height: 15)
        label.font = UIFont(name: "Montserrat-Medium", size: 12)

        return label
    }()
    
    lazy var bottomLeftStack: UIStackView = {
        let st = UIStackView(arrangedSubviews: [clockImage,
                                                durationLabel])
        st.axis = .horizontal
        st.spacing = 5
        st.alignment = .center
        return st
    }()
    
    lazy var starImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "star.fill")
        img.tintColor = .systemYellow
        return img
    }()
    
    lazy var reviewRaitingLabel: UILabel = {
        let label = UILabel()
        label.text = "(5.0)"
        label.font = Constants.Fonts.plusJacartaSansBold(with: 12)
        label.textColor = .systemYellow
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var reviewCountLabel: UILabel = {
        let label = UILabel()
        label.text = "(52)"
        label.font = Constants.Fonts.plusJacartaSansBold(with: 12)
        label.textColor = .gray
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var bottomRightStack: UIStackView = {
        let st = UIStackView(arrangedSubviews: [starImage,
                                                reviewRaitingLabel,
                                                reviewCountLabel])
        st.axis = .horizontal
        st.spacing = 5
        st.alignment = .center
        
        return st
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "favorite"), for: .normal)
        
        return button
    }()
    
    lazy var topStack: UIStackView = {
        let st = UIStackView(arrangedSubviews: [categoryLabel,
                                                favoriteButton])
        st.axis = .horizontal
        st.spacing = 205
        st.alignment = .leading
        
        return st
    }()
    
    lazy var bottomStack: UIStackView = {
        let st = UIStackView(arrangedSubviews: [bottomLeftStack,
                                               bottomRightStack])
        st.axis = .horizontal
        st.spacing = 85
        st.alignment = .center
        
        return st
    }()
    
    lazy var verticalStack: UIStackView = {
        let st = UIStackView(arrangedSubviews: [topStack,
                                                filmName,
                                                bottomStack])
        st.axis = .vertical
        st.spacing = 5
        st.alignment = .leading
        
        return st
    }()
    
    lazy var mainStack: UIStackView = {
        let st = UIStackView(arrangedSubviews: [image, verticalStack])
        st.axis = .horizontal
        st.spacing = 10
        st.translatesAutoresizingMaskIntoConstraints = false
        
        return st
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(mainStack)
        backgroundColor = UIColor(named: "BgColor")
        
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - ADDING METHODS

extension MoviesCellView {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
    }
    
}
