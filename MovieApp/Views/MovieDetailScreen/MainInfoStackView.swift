//
//  MainInfoStackView.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 07.04.2023.
//

import UIKit

enum DetailInfo: Int, CaseIterable {
    case date
    case time
    case genres
}

enum Rating {
    case five
    case four
    case three
    case two
    case one
}

class MainInfoStackView: UIStackView {
    
    var stars = [UIImageView](repeating: UIImageView(), count: 5)
    
    let viewC = UIView()
    
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
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Story Line"
        label.font = Constants.Fonts.plusJacartaSansSemiBold(with: 16)
        label.textColor = Constants.Colors.mainTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var overview: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = Constants.Fonts.plusJacartaSansMedium(with: 14)
        label.textColor = Constants.Colors.otherTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let actorLabel: UILabel = {
        let label = UILabel()
        label.text = "Cast and Crew"
        label.font = Constants.Fonts.plusJacartaSansSemiBold(with: 16)
        label.textColor = Constants.Colors.mainTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.frame = scroll.bounds
        scroll.showsHorizontalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
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
        addSubview(poster)
        addSubview(movieName)
        addSubview(hStack)
        
        DetailInfo.allCases.forEach { info in
            hStack.addArrangedSubview(InfoStack(icon: getImage(for: info), text: getText(for: info)))
        }
    
        addSubview(hStackReating)
        
        let vote_average = 7.916
        let percent = vote_average * 10
        let rating = getRating(percent: Int(percent.rounded()))
        stars = getArrayStars(rating: rating, image: UIImage(named: "star") ?? UIImage())
        
        stars.forEach(self.hStackReating.addArrangedSubview)
        
        hStackReating.contentMode = .scaleAspectFill
        hStackReating.spacing = 6
        
        addSubview(label)
        addSubview(overview)
    
        addSubview(actorLabel)
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
            
            hStack.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 16),
            hStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            hStackReating.topAnchor.constraint(equalTo: hStack.bottomAnchor, constant: 16),
            hStackReating.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            label.topAnchor.constraint(equalTo: hStackReating.bottomAnchor, constant: 32),
            
            overview.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16),
            overview.leadingAnchor.constraint(equalTo: leadingAnchor),
            overview.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            actorLabel.topAnchor.constraint(equalTo: overview.bottomAnchor, constant: 24)
        ])
    }
    
    private func getImage(for details: DetailInfo) -> UIImage {
        switch details {
        case .date: return UIImage(named: "date") ?? UIImage()
        case .time: return UIImage(named: "time") ?? UIImage()
        case .genres: return UIImage(named: "film") ?? UIImage()
        }
    }
    
    func getText(for details: DetailInfo) -> String {
        switch details {
        case .date: return "17 Sep 2021"
        case .time: return "148 Minutes"
        case .genres: return "Animation"
        }
    }
    
    func getRating(percent: Int) -> Rating {
        if percent > 80 {
            return Rating.five
        } else if percent > 60 {
            return Rating.four
        } else if percent > 40 {
            return Rating.three
        } else if percent > 20 {
            return Rating.two
        } else {
            return Rating.one
        }
    }
    
    private func getArrayStars(rating: Rating, image: UIImage) -> [UIImageView] {
        let color = UIColor(red: 0.98, green: 0.80, blue: 0.08, alpha: 1.00)
        switch rating {
        case .five:
            for _ in 1...stars.count {
                stars.append(UIImageView(image: image.withTintColor(color)))
            }
            return stars
        case .four:
            for _ in 1...4 {
                stars.append(UIImageView(image: image.withTintColor(color)))
            }
            stars.append(UIImageView(image: image))
            return stars
        case .three:
            for _ in 1...3 {
                stars.append(UIImageView(image: image.withTintColor(color)))
            }
            for _ in 1...2 {
                stars.append(UIImageView(image: image))
            }
            return stars
        case .two:
            for _ in 1...2 {
                stars.append(UIImageView(image: image.withTintColor(color)))
            }
            for _ in 1...3 {
                stars.append(UIImageView(image: image))
            }
            return stars
        case .one:
            stars.append(UIImageView(image: image.withTintColor(color)))
            for _ in 1...4 {
                stars.append(UIImageView(image: image))
            }
            return stars
        }
    }
}
