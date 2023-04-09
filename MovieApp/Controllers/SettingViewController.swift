//
//  SettingViewController.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 01.04.2023.
//

import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

class SettingViewController: UIViewController {

    enum MyConstants {
        static let logOutButtonImage: String = "logOutButton"
        static let userPhotoImage: String = "userPhoto"
        static let userNameText: String = "Andy Lexsian"
        static let userNicknameText: String = "@Andy1999"
    }
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: MyConstants.logOutButtonImage), for: .normal)
        button.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = MyConstants.userNameText
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(named: "MainTextColor")
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private lazy var userNicknameLabel: UILabel = {
        let label = UILabel()
        label.text = MyConstants.userNicknameText
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "MainTextColor")
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private lazy var userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: MyConstants.userPhotoImage)
        return imageView
    }()
    
    private lazy var userInformationStackView = UIStackView()
    private lazy var generalInformationStackView = UIStackView()
    
    private func setupViews() {
        view.addSubview(logOutButton)
        
        userInformationStackView = UIStackView(arrangedSubviews: [
            userNameLabel,
            userNicknameLabel
        ], axis: .vertical, spacing: 2)
        
        generalInformationStackView = UIStackView(arrangedSubviews: [
            userInformationStackView,
            userPhotoImageView
        ], axis: .horizontal, spacing: 12)

        view.addSubview(userInformationStackView)
        view.addSubview(generalInformationStackView)
        view.addSubview(tableView)
    }
    
    @objc private func logOutButtonTapped() {
        
    }
    
    private func setConstraints() {
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            logOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            logOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        userInformationStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userInformationStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 43),
            userInformationStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 92),
            userInformationStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -160),
            userInformationStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        generalInformationStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            generalInformationStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            generalInformationStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        ])
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: generalInformationStackView.topAnchor, constant: 40),
            tableView.bottomAnchor.constraint(equalTo: logOutButton.bottomAnchor, constant: 260)
        ])
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
    
// TABLE
    let idCell = "idCell"
    let idHeader = "idHeader"
    
    let tableView: UITableView = {
        let tableView = UITableView()
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
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idHeader) as? SettingHeaderTableViewCell
        header?.headerConfigure(section: section)
        return header ?? SettingHeaderTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
