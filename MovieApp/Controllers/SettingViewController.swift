//
//  SettingViewController.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 01.04.2023.
//

import UIKit

class SettingViewController: UIViewController {

    enum MyConstants {
        static let logOutButtonImage: String = "logOutButton"
        static let userPhotoImage: String = "userPhoto"
        static let userNameText: String = "Andy Lexsian"
        static let userNicknameText: String = "@Andy1999"
    }
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = MyConstants.userNameText
        label.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 18)
        label.textColor = UIColor(named: "MainTextColor")
        label.textAlignment = .left
        return label
    }()
    
    private lazy var userNicknameLabel: UILabel = {
        let label = UILabel()
        label.text = MyConstants.userNicknameText
        label.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 14)
        label.textColor = Constants.Colors.mainTextColor
        label.textAlignment = .left
        return label
    }()
    
    private lazy var userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: MyConstants.userPhotoImage)
        return imageView
    }()
    
    private lazy var userInformationStackView = UIStackView()
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: MyConstants.logOutButtonImage), for: .normal)
        button.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func logOutButtonTapped() {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: idCell)
        tableView.register(SettingHeaderTableViewCell.self, forHeaderFooterViewReuseIdentifier: idHeader)
        
        view.backgroundColor = UIColor(named: "BgColor")
        title = Constants.Titles.NavBar.setting
        navigationController?.tabBarItem.title = Constants.Titles.TabBar.title(for: .setting)
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        
        userInformationStackView = UIStackView(arrangedSubviews: [
            userNameLabel,
            userNicknameLabel
        ], axis: .vertical, spacing: 2)
        
        view.addSubview(userPhotoImageView)
        view.addSubview(userInformationStackView)
        view.addSubview(tableView)
        view.addSubview(logOutButton)
    }
  
    private func setConstraints() {
        userInformationStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userInformationStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            userInformationStackView.leadingAnchor.constraint(equalTo: userPhotoImageView.trailingAnchor, constant: 12),
            userInformationStackView.widthAnchor.constraint(equalToConstant: 115),
            userInformationStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        userPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 37),
            userPhotoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 56),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 56)
        ])
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: userPhotoImageView.bottomAnchor, constant: 32),
            tableView.bottomAnchor.constraint(equalTo: logOutButton.topAnchor, constant: -5),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -95),
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

// TABLE
    let idCell = "idCell"
    let idHeader = "idHeader"
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.backgroundColor = .clear
        return tableView
    }()
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 3
        default: break
        }
        return 0
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath) as? SettingTableViewCell
        cell?.cellConfigure(indexPath: indexPath)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idHeader) as? SettingHeaderTableViewCell
        header?.headerConfigure(section: section)
        return header ?? SettingHeaderTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(EditProfileViewController(), animated: true)
    }
}

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
