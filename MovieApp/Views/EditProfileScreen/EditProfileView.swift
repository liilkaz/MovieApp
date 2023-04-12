//
//  EditProfileView.swift
//  MovieApp
//
//  Created by Иван Осипов on 12.04.2023.
//

import UIKit

class EditProfileView: UIView {
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let avatarView: AvatarView = {
        let avatar = AvatarView()
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.imageView.image = UIImage(named: "profileIcon")
        avatar.twoImageView.image = UIImage(systemName: "pencil.circle.fill")
        avatar.twoImageView.tintColor = UIColor(hexString: "#514EB6")
        return avatar
    }()
    
    lazy var changePhotoView: ChangePhotoView = {
        let view = ChangePhotoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    // MARK: - input panel
    
    let firstNameInput: InputPanel = {
        let panel = InputPanel(inputField: UITextField(hasBorder: true, backgroundColor: nil, cornerRadius: 24, placeholder: "First Name"), title: "First Name")
        return panel
    }()
    
    let lastNameInput: InputPanel = {
        let panel = InputPanel(inputField: UITextField(hasBorder: true, backgroundColor: nil, cornerRadius: 24, placeholder: "Last Name"), title: "Last Name")
        return panel
    }()
    
    let emailInput: InputPanel = {
        let panel = InputPanel(inputField: UITextField(hasBorder: true, backgroundColor: nil, cornerRadius: 24, placeholder: "E-mail"), title: "E-mail")
        return panel
    }()
    
    let dateOfBirthInput: InputPanel = {
        let panel = InputPanel(inputField: UITextField(hasBorder: true, backgroundColor: nil, cornerRadius: 24, placeholder: "Date of Birth"),
                               title: "Date of Birth")
        panel.inputTextField.setupRightButton(with: UIImage(systemName: "calendar") ?? UIImage())
        return panel
    }()
    
    // MARK: - label
    
    let genderLabel: UILabel = {
        let label = UILabel(name: "Gender", font: Constants.Fonts.plusJacartaSansRegular(with: 14))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel(name: "Location", font: Constants.Fonts.plusJacartaSansRegular(with: 14))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        return label
    }()
    
    // MARK: - stack view
    
    let inputPanelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let checkboxStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Checkbox
    
    let maleCheckbox: CheckboxView = {
        let checkbox = CheckboxView()
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        checkbox.label.text = "Male"
        return checkbox
    }()
    
    let femaleCheckbox: CheckboxView = {
        let checkbox = CheckboxView()
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        checkbox.label.text = "Female"
        return checkbox
    }()
    
    // MARK: - text view
    
    let locationView: TextView = {
        let view = TextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let saveChangesButton: UIButton = {
        let button = UIButton(title: "Save Changes",
                              backgroundColor: UIColor(hexString: "#ECF1F6"),
                              titleColor: .systemGray,
                              font: Constants.Fonts.plusJacartaSansSemiBold(with: 16),
                              hasBorder: false,
                              cornerRadius: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - private methods

private extension EditProfileView {
    func setupView() {
        self.backgroundColor = .systemBackground
        self.addSubview(scrollView)
        self.addSubview(changePhotoView)
        
        scrollView.addSubview(avatarView)
        scrollView.addSubview(inputPanelStackView)
        scrollView.addSubview(genderLabel)
        scrollView.addSubview(checkboxStackView)
        scrollView.addSubview(locationLabel)
        scrollView.addSubview(locationView)
        scrollView.addSubview(saveChangesButton)
        
        inputPanelStackView.addArrangedSubview(firstNameInput)
        inputPanelStackView.addArrangedSubview(lastNameInput)
        inputPanelStackView.addArrangedSubview(emailInput)
        inputPanelStackView.addArrangedSubview(dateOfBirthInput)
        
        checkboxStackView.addArrangedSubview(maleCheckbox)
        checkboxStackView.addArrangedSubview(femaleCheckbox)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            changePhotoView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            changePhotoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            changePhotoView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            changePhotoView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            
            avatarView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            avatarView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 48),
            avatarView.heightAnchor.constraint(equalToConstant: 100),
            avatarView.widthAnchor.constraint(equalToConstant: 100),
            
            inputPanelStackView.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 16),
            inputPanelStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            inputPanelStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
            inputPanelStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            genderLabel.topAnchor.constraint(equalTo: inputPanelStackView.bottomAnchor, constant: 16),
            genderLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            
            checkboxStackView.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 8),
            checkboxStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            checkboxStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
            
            locationLabel.topAnchor.constraint(equalTo: checkboxStackView.bottomAnchor, constant: 16),
            locationLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            
            locationView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8),
            locationView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            locationView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
            locationView.heightAnchor.constraint(equalToConstant: 132),
            
            saveChangesButton.topAnchor.constraint(equalTo: locationView.bottomAnchor, constant: 64),
            saveChangesButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            saveChangesButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
            saveChangesButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -34),
            saveChangesButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}
