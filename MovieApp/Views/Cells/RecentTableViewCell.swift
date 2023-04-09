
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
        image.image = UIImage(named: "картинка")
        image.frame = CGRect(x: 24, y: 10, width: 119.52, height: 160)
        
        return image
    }()
    
    lazy var timeImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.image = UIImage(named: "time")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.frame = CGRect(x: 0, y: 0, width: 13.33, height: 13.33)
     //   image.layer.backgroundColor = UIColor(red: 0.263, green: 0.306, blue: 0.345, alpha: 1).cgColor

        return image
    }()
    
    lazy var dateImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.image = UIImage(named: "date")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.frame = CGRect(x: 0, y: 0, width: 12, height: 13.33)

        return image
    }()
    
    lazy var filmImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.image = UIImage(named: "film")
        image.frame = CGRect(x: 0, y: 0, width: 12, height: 12)
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()
    
    lazy var filmNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Drifting Home"
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 0, y: 0, width: 124, height: 26)
        label.font = Constants.Fonts.plusJacartaSansBold(with: 18)
        label.font = UIFont(name: "PlusJakartaSans-Bold", size: 18)
        label.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)

        return label
    }()

    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "\(148) Minutes"
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 0, y: 0, width: 74, height: 15)
        label.font = UIFont(name: "Montserrat-Medium", size: 12)
        label.textColor = UIColor(red: 0.471, green: 0.51, blue: 0.541, alpha: 1)

        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "11 Sep 2021"
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 0, y: 0, width: 69, height: 15)
        label.font = UIFont(name: "Montserrat-Medium", size: 12)
        label.textColor = UIColor(red: 0.471, green: 0.51, blue: 0.541, alpha: 1)

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
//        label.frame = CGRect(x: 16.5, y: 3, width: 65, height: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Fonts.plusJacartaSansBold(with: 10)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "favorite"), for: .normal)

        return button
    }()

    private lazy var ImageStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [timeImage, dateImage, filmImage])
        stack.spacing = 14.67
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [timeLabel, dateLabel])
        stack.spacing = 8
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        self.addSubview(movieImage)
        self.addSubview(filmNameLabel)
        self.addSubview(ImageStackView)
        self.addSubview(labelStackView)
        self.addSubview(favoriteButton)
        self.addSubview(actionView)
        actionView.addSubview(categorisLabel)
        NSLayoutConstraint.activate([
              filmNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
              filmNameLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 13),
              
              ImageStackView.topAnchor.constraint(equalTo: filmNameLabel.bottomAnchor, constant: 13.33),
              ImageStackView.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 13),
            
              labelStackView.topAnchor.constraint(equalTo: filmNameLabel.bottomAnchor, constant: 10),
              labelStackView.leadingAnchor.constraint(equalTo: ImageStackView.trailingAnchor, constant: 5.33),
              
              favoriteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
              favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
              
              categorisLabel.centerXAnchor.constraint(equalTo: actionView.centerXAnchor),
              categorisLabel.centerYAnchor.constraint(equalTo: actionView.centerYAnchor),
              
              actionView.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 8),
              actionView.leadingAnchor.constraint(equalTo: ImageStackView.trailingAnchor, constant: 5.33),
              actionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -145),
              actionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -52)
        ])
    }
}
