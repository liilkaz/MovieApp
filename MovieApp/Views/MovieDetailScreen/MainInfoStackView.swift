//
//  MainInfoStackView.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 07.04.2023.
//

import UIKit

enum Rating {
    case five
    case four
    case three
    case two
    case one
}

class MainInfoStackView: UIStackView {

    let viewC = UIView()
    
    let dateStack = InfoStack(icon: UIImage(named: "date") ?? UIImage())
    let timeStack = InfoStack(icon: UIImage(named: "time") ?? UIImage())
    let genreStack = InfoStack(icon: UIImage(named: "film") ?? UIImage())

    lazy var poster: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 16
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var movieName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = Constants.Fonts.plusJacartaSansBold(with: 24)
        label.textColor = Constants.Colors.mainTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let hStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let hStackReating: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
//    let label: UILabel = {
//        let label = UILabel()
//        label.text = "Story Line"
//        label.font = Constants.Fonts.plusJacartaSansSemiBold(with: 16)
//        label.textColor = Constants.Colors.mainTextColor
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
//    let overview: ExpandableLabel = {
//        let label = ExpandableLabel()
//        label.numberOfLines = 0
//        label.textAlignment = .left
//        label.font = Constants.Fonts.plusJacartaSansMedium(with: 14)
//        label.textColor = Constants.Colors.otherTextColor
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
//    let actorLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Cast and Crew"
//        label.font = Constants.Fonts.plusJacartaSansSemiBold(with: 16)
//        label.textColor = Constants.Colors.mainTextColor
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
//    let scroll: UIScrollView = {
//        let scroll = UIScrollView()
//        scroll.frame = scroll.bounds
//        scroll.showsHorizontalScrollIndicator = false
//        scroll.translatesAutoresizingMaskIntoConstraints = false
//        return scroll
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(poster)
        addSubview(movieName)
        addSubview(hStack)
        hStack.addArrangedSubview(dateStack)
        hStack.addArrangedSubview(timeStack)
        hStack.addArrangedSubview(genreStack)
        addSubview(hStackReating)
        
        hStackReating.contentMode = .scaleAspectFill
        hStackReating.spacing = 6
        
//        addSubview(label)
//        addSubview(overview)
    
//        addSubview(actorLabel)
        axis = .vertical
        contentMode = .center
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            poster.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            poster.heightAnchor.constraint(equalToConstant: 300),
            poster.widthAnchor.constraint(equalToConstant: 225),
            poster.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            movieName.topAnchor.constraint(equalTo: poster.bottomAnchor, constant: 24),
            movieName.centerXAnchor.constraint(equalTo: centerXAnchor),
            movieName.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieName.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            hStack.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 16),
            hStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            hStackReating.topAnchor.constraint(equalTo: hStack.bottomAnchor, constant: 16),
            hStackReating.centerXAnchor.constraint(equalTo: centerXAnchor),
            
//            label.topAnchor.constraint(equalTo: hStackReating.bottomAnchor, constant: 32),
//
//            overview.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16),
//            overview.leadingAnchor.constraint(equalTo: leadingAnchor),
//            overview.trailingAnchor.constraint(equalTo: trailingAnchor),
//
//            actorLabel.topAnchor.constraint(equalTo: overview.bottomAnchor, constant: 24)
        ])
    }
}
