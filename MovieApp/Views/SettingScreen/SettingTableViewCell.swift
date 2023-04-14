//
//  SettingTableViewCell.swift
//  MovieApp
//
//  Created by Alina Artamonova on 10.04.2023.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    let cellNameArray = [["Profile"],
                     ["Change Password", "Change Password", "Dark Mode"]]
    
    let cellSettingImageArray = [["person"],
                     ["lock", "unlock", "darkMode"]]

    private var theme: Theme?

    var didTapped: (() -> Void)?
    
    private lazy var nameSetting: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "MainTextColor")
        label.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var settingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var vectorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var reapeatSwitch: UISwitch = {
        let reapeatSwitch = UISwitch()
        reapeatSwitch.isOn = true
        reapeatSwitch.isHidden = true
        reapeatSwitch.translatesAutoresizingMaskIntoConstraints = false
        return reapeatSwitch
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()

        self.selectionStyle = .none
        self.backgroundColor = .clear
        settingSwitch()
        reapeatSwitch.addTarget(self, action: #selector(switchChange(paramTarget:)), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("alina")
    }

    private func settingSwitch() {
        switch Theme.current {

        case .light:
            reapeatSwitch.isOn = false
        case .dark:
            reapeatSwitch.isOn = true
        }
    }
    
    func cellConfigure(indexPath: IndexPath) {
        nameSetting.text = cellNameArray[indexPath.section][indexPath.row]
        settingImage.image = UIImage(named: cellSettingImageArray[indexPath.section][indexPath.row])
        if indexPath == [2, 2] {
            
        }
        if indexPath == [1, 2] {
            reapeatSwitch.isHidden = false
        }
        if indexPath == [0, 0] {
            vectorImage.image = UIImage(named: "vector")
        }
    }
    
    @objc func switchChange(paramTarget: UISwitch) {
        theme = paramTarget.isOn ? .dark : .light
        theme?.save()
        didTapped?()
        print("switch")
    }
    
    func setConstraints() {
        
        let cellInformationStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.addArrangedSubview(settingImage)
            stackView.addArrangedSubview(nameSetting)
            stackView.axis = .horizontal
            stackView.spacing = 12
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        self.addSubview(cellInformationStackView)
        NSLayoutConstraint.activate([
            cellInformationStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cellInformationStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24)
        ])
        self.contentView.addSubview(vectorImage)
        NSLayoutConstraint.activate([
            vectorImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            vectorImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
        ])
        self.contentView.addSubview(reapeatSwitch)
        NSLayoutConstraint.activate([
            reapeatSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            reapeatSwitch.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
}
