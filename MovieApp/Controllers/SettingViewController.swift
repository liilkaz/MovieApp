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

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    enum MyConstants {
        static let logOutButtonImage: String = "logOutButton"
        static let userPhotoImage: String = "userPhoto"
        static let userNameText: String = "Andy Lexsian"
        static let userNicknameText: String = "@blablabla"
        static let logOutButtonbottomAnchor: CGFloat = 100
        static let logOutButtonLeadingAnchor: CGFloat = 18
        static let logOutButtonTrailingAnchor: CGFloat = 22
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
        label.textColor = .red
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private lazy var userNicknameLabel: UILabel = {
        let label = UILabel()
        label.text = MyConstants.userNicknameText
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .red
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
    }
    
    @objc private func logOutButtonTapped() {
    }
    
    private func setConstraints() {
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -MyConstants.logOutButtonbottomAnchor),
            logOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: MyConstants.logOutButtonLeadingAnchor),
            logOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -MyConstants.logOutButtonTrailingAnchor),
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
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 212),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 266)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTable()
        
        view.backgroundColor = UIColor(named: "BgColor")
        title = Constants.Titles.NavBar.setting
        navigationController?.tabBarItem.title = Constants.Titles.TabBar.title(for: .setting)
        setupViews()
        setConstraints()
    }
    //MAKE TABLE
    
    var tableView = UITableView()
    let identifire = "alina"
    
    func createTable() {
        self.tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifire)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
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
        let cell = tableView.dequeueReusableCell(withIdentifier: identifire , for: indexPath)
        cell.textLabel!.text = "alina"
        return cell
    }
    
}
