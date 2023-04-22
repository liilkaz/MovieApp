//
//  AllMoviesViewCell.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 19.04.2023.
//

import UIKit

class AllMoviesViewCell: UICollectionViewCell {
    
    static let identifier = "MoviesCollectionView"
    
    var didTapedFavoriteButton: (() -> Void)?
    
    private var movieId: Int?
    private let userDataSource = UserDataSource()
    private var userModel: UserModel?
    
    var isFavorite: Bool = false {
        didSet {
            favoriteButton.imageView?.image = nil
            let image = UIImage(named: isFavorite ? "favorite_fill" : "favorite")
            favoriteButton.setImage(image, for: .normal)
        }
    }
    
    lazy var image: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "secondMovie")
        img.layer.cornerRadius = 16
        img.layer.masksToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Action"
        label.font = Constants.Fonts.plusJacartaSansMedium(with: 12)
        label.textColor = Constants.Colors.otherTextColor
        label.textAlignment = .left
        return label
    }()
    
    lazy var filmName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "Film name"
        label.font = Constants.Fonts.plusJacartaSansBold(with: 18)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
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
        label.font = Constants.Fonts.montserratMedium(with: 12)

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
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        let image = UIImage(named: isFavorite ? "favorite_fill" : "favorite")
        button.setImage(image, for: .normal)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            addSubview(mainStack)
            backgroundColor = UIColor(named: "BgColor")
            
            setupConstraints()
        }
    
    @objc func didTapLike() {
        isFavorite.toggle()
        didTapedFavoriteButton?()
        
        guard let movie = movieId else { return }
        if isFavorite {
            userDataSource.saveFavorite(with: movie, in: AllMovies.shared.userId)
        } else {
            userDataSource.deleteFavorite(for: AllMovies.shared.userId, movieId: Int64(movie))
        }
    }
    
    func configure (url: URL?, movieName: String, rating: String, vote_count: String, movieId: Int, isFavorite: Bool) {
        image.sd_setImage(with: url)
        filmName.text = movieName
//        durationLabel.text = runtime
        reviewRaitingLabel.text = rating
        reviewCountLabel.text = vote_count
        self.movieId = movieId
        self.isFavorite = isFavorite
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 80),
            image.heightAnchor.constraint(equalToConstant: 80),
            
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            filmName.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor, constant: -20)
            
        ])
    }
    
}
