//
//  SettingViewController.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 01.04.2023.
//

import UIKit
import Combine

class SettingViewController: UIViewController {

    private var anyCancellable = Set<AnyCancellable>()

    enum MyConstants {
        static let logOutButtonImage: String = "logOutButton"
//        static let userNameText: String = "Andy Lexsian"
//        static let userNicknameText: String = "@Andy1999"
    }

    private var userModel: UserModel?
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
//        label.text = MyConstants.userNameText
        label.font = Constants.Fonts.plusJacartaSansSemiBold(with: 18)
        label.textColor = Constants.Colors.mainTextColor
        label.textAlignment = .left
        return label
    }()
    
    private lazy var userNicknameLabel: UILabel = {
        let label = UILabel()
//        label.text = MyConstants.userNicknameText
        label.font = Constants.Fonts.plusJacartaSansSemiBold(with: 14)
        label.textColor = Constants.Colors.mainTextColor
        label.textAlignment = .left
        return label
    }()
    
    private lazy var userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 0.3
        imageView.clipsToBounds = true
        imageView.layer.borderColor = Constants.Colors.mainTextColor?.cgColor
        
        return imageView
    }()
    
    private lazy var userInformationStackView = UIStackView()
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton(title: "Log Out",
                              backgroundColor: Constants.Colors.backgroundColor,
                              titleColor: Constants.Colors.active,
                              font: Constants.Fonts.plusJacartaSansMedium(with: 16),
                              hasBorder: true,
                              cornerRadius: 32)
        button.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func logOutButtonTapped() {
        print("logout")
        AuthService.shared.logout()
        let logVC = LoginViewController()
        logVC.modalPresentationStyle = .fullScreen
        present(logVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = Constants.Titles.NavBar.setting
        navigationController?.tabBarItem.title = Constants.Titles.TabBar.title(for: .setting)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserModel()
        setUserInfo()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: idCell)
        tableView.register(SettingHeaderTableViewCell.self, forHeaderFooterViewReuseIdentifier: idHeader)
        
        view.backgroundColor = Constants.Colors.backgroundColor
        setupViews()
        setConstraints()
    }

    private func getUserModel() {
        userModel = UserDataSource().getUser(for: AllMovies.shared.userId)
    }

    private func setUserInfo() {
        userNameLabel.text = "\(userModel?.firstName ?? "no") \(userModel?.lastName ?? "no")"
        userNicknameLabel.text = "\(userModel?.email ?? "no")"
    }
    
    private func setupViews() {
        userPhotoImageView.layer.cornerRadius = 28
        
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
//            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            logOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            logOutButton.heightAnchor.constraint(equalToConstant: 60)
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
        cell?.didTapped = { [weak self] in
            self?.animationSetTheme()
        }
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
        print(indexPath)

        if indexPath.section == 0 {
            navigationController?.pushViewController(EditProfileViewController(), animated: true)
        }

        if indexPath == [1, 0] {
            showUpdateAlert()
        }

        if indexPath == [1, 1] {
            guard let email = AuthService.shared.getEmailUser() else { return }
            AuthService.shared.resetPassword()
            showAlert(with: "Password Reset", and: "send email on \(email)")
        }
    }

    func showUpdateAlert() {

        let alertController = UIAlertController(title: "Change password", message: "new password 6 or more chars", preferredStyle: .alert)

        var alertTextField = UITextField()
        alertTextField.isSecureTextEntry = true
        let addActionButton = UIAlertAction(title: "Change", style: .default) { _ in
            guard let newPassword = alertTextField.text else { return }
            AuthService.shared.updatePassword(newPass: newPassword)
        }

        addActionButton.isEnabled = false

        alertController.addTextField { alertTF in
            alertTF.placeholder = "Input new password"
            alertTextField = alertTF
        }

        alertTextField.textPublisher()
            .sink(receiveValue: { text in
                let trimmedStr = text.trimmingCharacters(in: .whitespacesAndNewlines)
                addActionButton.isEnabled = !trimmedStr.isEmpty
            })
            .store(in: &self.anyCancellable)

        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel)

        alertController.addAction(addActionButton)
        alertController.addAction(cancelActionButton)
        alertController.preferredAction = addActionButton
        present(alertController, animated: true)
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

private extension SettingViewController {
    func animationSetTheme() {
        UIView.animate(withDuration: 0.3) {
            self.view.window?.overrideUserInterfaceStyle = Theme.current.userInterfaceStyle
        }
    }
}
