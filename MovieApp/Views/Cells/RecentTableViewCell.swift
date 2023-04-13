//
//  UITableViewCell.swift
//  MovieApp
//
//  Created by Fazil Jabbarov 11 on 04.04.2023.
//

import UIKit

class RecentTableViewCell: UITableViewCell {
    
    static let identifier = "\(RecentTableViewCell.self)"
   
    lazy var movieImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 16
        image.layer.masksToBounds = true
//        image.image = UIImage(named: "картинка")
        image.frame = CGRect(x: 24, y: 10, width: 119.52, height: 160)
        
        return image
    }()
    
    lazy var timeImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "time")?.withTintColor(Constants.Colors.iconThemeColor ?? UIColor.black))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.frame = CGRect(x: 0, y: 0, width: 13.33, height: 13.33)

        return image
    }()
    
    lazy var dateImage: UIImageView = {
            let image = UIImageView(image: UIImage(named: "date")?.withTintColor(Constants.Colors.iconThemeColor ?? UIColor.black))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.frame = CGRect(x: 0, y: 0, width: 12, height: 13.33)

        return image
    }()
    
    lazy var filmImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "film")?.withTintColor(Constants.Colors.iconThemeColor ?? UIColor.black))
        image.frame = CGRect(x: 0, y: 0, width: 12, height: 12)
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()
    
    lazy var filmNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
//        label.text = "Drifting Home"
        label.textColor = Constants.Colors.mainTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 0, y: 0, width: 124, height: 26)
        label.font = Constants.Fonts.plusJacartaSansBold(with: 18)

        return label
    }()

    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "\(148) Minutes"
        label.textColor = Constants.Colors.mainTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 0, y: 0, width: 74, height: 15)
        label.font = UIFont(name: "Montserrat-Medium", size: 12)

        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "11 Sep 2021"
        label.textColor = Constants.Colors.mainTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 0, y: 0, width: 69, height: 15)
        label.font = UIFont(name: "Montserrat-Medium", size: 12)

        return label
    }()
    
    lazy var actionView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.318, green: 0.306, blue: 0.714, alpha: 1)

        return view
    }()
    
    lazy var categorisLabel: UILabel = {
        let label = UILabel()
        label.text = "Action"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Fonts.plusJacartaSansBold(with: 10)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "favorite"), for: .normal)
        return button
    }()

    private lazy var ImageStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [timeImage, dateImage, filmImage])
        stack.spacing = 12
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [timeLabel, dateLabel])
        stack.spacing = 12
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor(named: "BgColor")
        setConstraints()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        contentView.addSubview(movieImage)
        contentView.addSubview(filmNameLabel)
        contentView.addSubview(ImageStackView)
        contentView.addSubview(labelStackView)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(actionView)
        contentView.addSubview(categorisLabel)
        NSLayoutConstraint.activate([
              filmNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
              filmNameLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 13),
              filmNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
              
              ImageStackView.topAnchor.constraint(equalTo: filmNameLabel.bottomAnchor, constant: 12),
              ImageStackView.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 13),
            
              labelStackView.topAnchor.constraint(equalTo: filmNameLabel.bottomAnchor, constant: 11),
              labelStackView.leadingAnchor.constraint(equalTo: ImageStackView.trailingAnchor, constant: 5.33),
              
              favoriteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
              favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
              
              categorisLabel.centerXAnchor.constraint(equalTo: actionView.centerXAnchor),
              categorisLabel.centerYAnchor.constraint(equalTo: actionView.centerYAnchor),
              
              actionView.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 8),
              actionView.leadingAnchor.constraint(equalTo: ImageStackView.trailingAnchor, constant: 5.33),
              actionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -145),
//              actionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -52),
              actionView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
