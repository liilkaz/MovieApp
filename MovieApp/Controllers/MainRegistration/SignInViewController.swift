//
//  SignInViewController.swift
//  MovieApp
//
//  Created by Djinsolobzik on 03.04.2023.
//

import UIKit

class SignInViewController: UIViewController {

// MARK: - Private properties

    private enum TypeInputField: Int {
        case fistName
        case lastName
        case email
        case password
        case confirmPassword
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel(name: "Complet your account",
                            font: Constants.Fonts.plusJacartaSansBold(with: 24))
        label.textColor = .label
        return label
    }()

    private lazy var subTitleLabel: UILabel = {
        let label = UILabel(name: "Lorem ipsum dolor sit amet", font: Constants.Fonts.plusJacartaSansMedium(with: 16))
        label.textColor = .label
        return label
    }()

    private lazy var firstNameInput: InputPanel = {
        let panel = InputPanel(inputField: UITextField(hasBorder: false,
                                                       backgroundColor: UIColor(named: "BgColor"),
                                                       cornerRadius: 24,
                                                       placeholder: "Enter your first name"),
                               title: "First Name")
        return panel
    }()

    private lazy var lastNameInput: InputPanel = {
        let panel = InputPanel(inputField: UITextField(hasBorder: false,
                                                       backgroundColor: UIColor(named: "BgColor"),
                                                       cornerRadius: 24,
                                                       placeholder: "Enter your last name"), title: "Last Name")
        return panel
    }()

    private lazy var emailInput: InputPanel = {
        let panel = InputPanel(inputField: UITextField(hasBorder: false,
                                                       backgroundColor: UIColor(named: "BgColor"),
                                                       cornerRadius: 24,
                                                       placeholder: "Enter your email"), title: "E-mail")
        panel.inputTextField.keyboardType = .emailAddress
        return panel
    }()

    private lazy var showHidePasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("     ", for: .normal)
        button.tintColor = .systemGray
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var showHideConfirmPasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("     ", for: .normal)
        button.tintColor = .systemGray
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var passwordInput: InputPanel = {
        let panel = InputPanel(inputField: UITextField(hasBorder: false,
                                                       backgroundColor: UIColor(named: "BgColor"),
                                                       cornerRadius: 24,
                                                       placeholder: "Enter your password"), title: "Password")
        panel.inputTextField.isSecureTextEntry = true
        panel.inputTextField.rightView = showHidePasswordButton
        panel.inputTextField.rightViewMode = .always
        return panel
    }()

    private lazy var confirmPasswordInput: InputPanel = {
        let panel = InputPanel(inputField: UITextField(hasBorder: false,
                                                       backgroundColor: UIColor(named: "BgColor"),
                                                       cornerRadius: 24,
                                                       placeholder: "Confirm your password"), title: "Confirm Password")
        panel.inputTextField.isSecureTextEntry = true
        panel.inputTextField.rightView = showHideConfirmPasswordButton
        panel.inputTextField.rightViewMode = .always
        return panel
    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton(title: "Sign Up", backgroundColor: UIColor(named: "Onboarding"), titleColor: .white, hasBorder: false, cornerRadius: 24)
        button.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        return button
    }()

    private lazy var bottomText: UILabel = {
        let label = UILabel(name: "Already hav an account?", font: Constants.Fonts.plusJacartaSansMedium(with: 16))
        label.textColor = .systemGray
        return label
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = Constants.Fonts.plusJacartaSansMedium(with: 16)
        button.setTitleColor(UIColor(named: "Onboarding"), for: .normal)
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        return button
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        setLayout()
        view.backgroundColor = .systemBackground
        hideKeyboardWhenTappedAround()
    }

    private func setLayout() {

        let bottomStackView = UIStackView(arrangedSubviews: [bottomText, loginButton])
        bottomStackView.axis = .horizontal

        let mainStackView = UIStackView(arrangedSubviews: [firstNameInput, lastNameInput, emailInput, passwordInput, confirmPasswordInput])
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 24

        view.addSubviews(titleLabel, subTitleLabel, mainStackView, signUpButton, bottomStackView) {[

            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            mainStackView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 32),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            mainStackView.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -48),

            signUpButton.bottomAnchor.constraint(equalTo: bottomStackView.topAnchor, constant: -24),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            signUpButton.heightAnchor.constraint(equalToConstant: 56),

            bottomStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomStackView.widthAnchor.constraint(equalToConstant: 230),
            bottomStackView.heightAnchor.constraint(equalToConstant: 22)
        ]}
    }

    private func setNavBar() {
        title = "Sign Up"
        navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(
            image: UIImage(named: "arrowBack")?.withTintColor(.systemGray,
                                                              renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(didTapBackButton))
        navigationItem.leftBarButtonItem = backButton
    }

    // MARK: - Objc Methods

    @objc
    private func didTapSignUp() {
        let userFullName = "\(firstNameInput.inputTextField.text ?? "NoName") \(lastNameInput.inputTextField.text ?? "NoFamily")"
        AuthService.shared.register(
            email: emailInput.inputTextField.text,
            password: passwordInput.inputTextField.text,
            confirmPassword: confirmPasswordInput.inputTextField.text) { [weak self] result in
                switch result {

                case .success(_):
                    let homeVC = TabBarViewController()
                    homeVC.modalPresentationStyle = .fullScreen
                    self?.present(homeVC, animated: true)
                case .failure(let error):
                    self?.showAlert(with: "Ошибка!", and: error.localizedDescription)
                }
        }
    }

    @objc
    private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
        print("didTapBackButton")
    }

    @objc
    private func didTapLoginButton() {
        let secondLoginVC = SecondLoginViewController()
        present(secondLoginVC, animated: true)
    }

    @objc
    private func showHideButtonTapped(sender: UIButton) {
        if sender == showHidePasswordButton {
            passwordInput.inputTextField.isSecureTextEntry.toggle()

                if passwordInput.inputTextField.isSecureTextEntry {
                    showHidePasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
                } else {
                    showHidePasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
                }
        } else {
            confirmPasswordInput.inputTextField.isSecureTextEntry.toggle()

                if confirmPasswordInput.inputTextField.isSecureTextEntry {
                    showHideConfirmPasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
                } else {
                    showHideConfirmPasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
                }
        }

    }
}
