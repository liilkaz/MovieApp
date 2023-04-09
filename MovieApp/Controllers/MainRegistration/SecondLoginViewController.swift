//
//  SecondLoginViewController.swift
//  MovieApp
//
//  Created by Djinsolobzik on 04.04.2023.
//

import UIKit

final class SecondLoginViewController: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(name: "Login", font:
                                Constants.Fonts.plusJacartaSansBold(with: 24))
        label.textColor = .white
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel(name: "Loramer sendjuper Login", font: Constants.Fonts.plusJacartaSansMedium(with: 16))
        label.textColor = .white
        return label
    }()
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var emailInput: InputPanel = {
        let panel = InputPanel(inputField: UITextField(hasBorder: false,
                                                       backgroundColor: UIColor(named: "BgColor"),
                                                       cornerRadius: 24, placeholder: "Enter your email address"), title: "Email")
        return panel
    }()
    
    private lazy var passwordInput: InputPanel = {
        let panel = InputPanel(inputField: UITextField(hasBorder: false,
                                                       backgroundColor: UIColor(named: "BgColor"),
                                                       cornerRadius: 24, placeholder: "Enter your password"), title: "Password")
        panel.inputTextField.isSecureTextEntry = true
        panel.inputTextField.rightView = showHidePasswordButton
        panel.inputTextField.rightViewMode = .always
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
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(title: "Login", backgroundColor: UIColor(named: "Onboarding"), titleColor: .white, hasBorder: false, cornerRadius: 24)
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var bottomText: UILabel = {
        let label = UILabel(name: "Already hav an account?", font: Constants.Fonts.plusJacartaSansMedium(with: 16))
        label.textColor = .systemGray
        return label
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Private Methods
    
    private func setLayout() {
        view.backgroundColor = UIColor(named: "Onboarding")
        
        view.addSubviews(titleLabel, subTitleLabel, backView) {[
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            backView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 48),
            backView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]}
        
        backView.layer.cornerRadius = 32
        backView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        backView.addSubviews(emailInput, passwordInput, loginButton) {[
            
            emailInput.topAnchor.constraint(equalTo: backView.topAnchor, constant: 48),
            emailInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emailInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            emailInput.heightAnchor.constraint(equalToConstant: 88),
            
            passwordInput.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 24),
            passwordInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            passwordInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            passwordInput.heightAnchor.constraint(equalToConstant: 88),
            
            loginButton.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 48),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            loginButton.heightAnchor.constraint(equalToConstant: 56)
            
        ]}
    }
    
    // MARK: - @OBJC Methods
    
    @objc
    private func didTapEmailButton() {
        let signInVC = SignInViewController()
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
    @objc
    private func didTapLoginButton() {
        AuthService.shared.login(email: emailInput.inputTextField.text, password: passwordInput.inputTextField.text) { [weak self] result in
            switch result {

            case .success(let user):
                let homeVC = TabBarViewController()
                homeVC.modalPresentationStyle = .fullScreen
                self?.present(homeVC, animated: true)
                print(user)
            case .failure(let error):
                self?.showAlert(with: "Ошибка", and: error.localizedDescription)
            }
        }
    }
    
    @objc
    private func showHideButtonTapped(sender: UIButton) {
        
        passwordInput.inputTextField.isSecureTextEntry.toggle()
        
        if passwordInput.inputTextField.isSecureTextEntry {
            showHidePasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            showHidePasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
}
