//
//  SettingHeaderTableViewCell.swift
//  MovieApp
//
//  Created by Alina Artamonova on 08.04.2023.
//

import UIKit

class SettingHeaderTableViewCell: UITableViewHeaderFooterView {
    
    let headerNameArray = ["Personal Info", "Security"]
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "MainTextColor")
        label.font = UIFont(name: "PlusJakartaSans-Medium", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("alina")
    }
    
    func headerConfigure(section: Int) {
        headerLabel.text = headerNameArray[section]
    }
    
    func setConstraints() {
        self.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24)
        ])
    }
}
