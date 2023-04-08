//
//  SettingTableViewSell.swift
//  MovieApp
//
//  Created by Alina Artamonova on 07.04.2023.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    let cellNameArray = [["Profile"],
                     ["Change Password", "Change Password", "Dark Mode"]]
    
    let cellSettingImageArray = [["person"],
                     ["lock", "unlock", "darkMode"]]
    
    let nameSetting: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "MainTextColor")
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let settingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let reapeatSwitch: UISwitch = {
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
        
        reapeatSwitch.addTarget(self, action: #selector(switchChange(paramTarget:)), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("alina")
    }
    
    func cellConfigure(indexPath: IndexPath) {
        nameSetting.text = cellNameArray[indexPath.section][indexPath.row]
        settingImage.image = UIImage(named: cellSettingImageArray[indexPath.section][indexPath.row])
        if indexPath == [2, 2] {
            
        }
        if indexPath == [1, 2] {
            reapeatSwitch.isHidden = false
        }
    }
    
    @objc func switchChange(paramTarget: UISwitch) {
    }
    
    func setConstraints() {
        self.addSubview(nameSetting)
        NSLayoutConstraint.activate([
            nameSetting.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameSetting.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60)
        ])
        self.addSubview(settingImage)
        NSLayoutConstraint.activate([
            settingImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            settingImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24)
        ])
        
        self.contentView.addSubview(reapeatSwitch)
        NSLayoutConstraint.activate([
            reapeatSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            reapeatSwitch.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ])
    }
    
}
