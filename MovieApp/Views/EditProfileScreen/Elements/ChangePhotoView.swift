//
//  ChangePhotoView.swift
//  MovieApp
//
//  Created by Иван Осипов on 12.04.2023.
//

import UIKit

class ChangePhotoView: UIView {
    
    let view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel(name: "Change your picture", font: Constants.Fonts.plusJacartaSansBold(with: 20))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let takePhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Take a photo", for: .normal)
        button.setupImage(UIImage(systemName: "camera"))
        button.backgroundColor = UIColor(hexString: "#F5F5F5")
        button.setTitleColor(.label, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .left
        button.layer.cornerRadius = 8
        return button
    }()
    
    let choosePhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Choose from your file", for: .normal)
        button.setupImage(UIImage(systemName: "folder.fill"))
        button.backgroundColor = UIColor(hexString: "#F5F5F5")
        button.setTitleColor(.label, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        return button
    }()
    
    let deletePhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete Photo", for: .normal)
        button.setupImage(UIImage(systemName: "trash.fill"))
        button.backgroundColor = UIColor(hexString: "#F5F5F5")
        button.setTitleColor(.systemRed, for: .normal)
        button.tintColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.cornerRadius = 8
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ChangePhotoView {
    func setupView() {
        self.backgroundColor = UIColor(white: 0.3, alpha: 0.4)
        self.addSubview(view)

        view.addSubview(label)
        view.addSubview(takePhotoButton)
        view.addSubview(choosePhotoButton)
        view.addSubview(deletePhotoButton)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: 180),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            takePhotoButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
            takePhotoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            takePhotoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            takePhotoButton.heightAnchor.constraint(equalToConstant: 60),
            
            choosePhotoButton.topAnchor.constraint(equalTo: takePhotoButton.bottomAnchor, constant: 20),
            choosePhotoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            choosePhotoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            choosePhotoButton.heightAnchor.constraint(equalToConstant: 60),
            
            deletePhotoButton.topAnchor.constraint(equalTo: choosePhotoButton.bottomAnchor, constant: 20),
            deletePhotoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            deletePhotoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            deletePhotoButton.heightAnchor.constraint(equalToConstant: 60),
            deletePhotoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
}
