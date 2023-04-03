//
//  LoginViewController.swift
//  MovieApp
//
//  Created by Djinsolobzik on 03.04.2023.
//

import UIKit

final class LoginViewController: UIViewController {

// MARK: - Private properties

    private lazy var titleLabel: UILabel = {
        let label = UILabel(name: "Create account", font:  K.Fonts.plusJacartaSansBold(with: 24))
        label.textColor = .white
        return label
    }()

    private lazy var subTitleLabel: UILabel = {
        let label = UILabel(name: "Lorem ipsum dolor sit amet", font: K.Fonts.plusJacartaSansMedium(with: 16))
        label.textColor = .white
        return label
    }()

    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()

    private lazy var emailInput: InputPanel = {
        let panel = InputPanel(inputField: UITextField(hasBorder: false, backgroundColor: UIColor(named: "BgColor"), cornerRadius: 24, placeholder: "Enter your email address"), title: "Email")
        return panel
    }()

    private lazy var emailButton: UIButton = {
        let button = UIButton(title: "Continue with Email", backgroundColor: UIColor(named: "Onboarding"), titleColor: .white, hasBorder: false, cornerRadius: 24)
        button.addTarget(self, action: #selector(didTapEmailButton), for: .touchUpInside)
        return button
    }()

    private lazy var dividerView: DividerView = {
        let view = DividerView(title: "Or continue with")
        //view.backgroundColor = .black
        return view
    }()

    private lazy var googleButton: UIButton = {
        let button = UIButton(title: "Continue with Google", backgroundColor: .systemBackground, titleColor: .label, hasBorder: true, cornerRadius: 24)
        button.setupGoogleImage()
        return button
    }()

    private lazy var bottomText: UILabel = {
        let label = UILabel(name: "Already hav an account?", font: K.Fonts.plusJacartaSansMedium(with: 16))
        label.textColor = .systemGray
        return label
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = K.Fonts.plusJacartaSansMedium(with: 16)
        button.setTitleColor(UIColor(named: "Onboarding"), for: .normal)
        return button
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

        let bottomStackView = UIStackView(arrangedSubviews: [bottomText, loginButton])
        bottomStackView.axis = .horizontal
        
        backView.addSubviews(emailInput, emailButton, dividerView, googleButton, bottomStackView) {[

                    emailInput.topAnchor.constraint(equalTo: backView.topAnchor, constant: 48),
                    emailInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                    emailInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                    emailInput.heightAnchor.constraint(equalToConstant: 88),

                    emailButton.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 32),
                    emailButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                    emailButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                    emailButton.heightAnchor.constraint(equalToConstant: 56),

                    dividerView.topAnchor.constraint(equalTo: emailButton.bottomAnchor, constant: 32),
                    dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
                    dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48),
                    dividerView.heightAnchor.constraint(equalToConstant: 22),

                    googleButton.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 32),
                    googleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                    googleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                    googleButton.heightAnchor.constraint(equalToConstant: 56),

                    bottomStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
                    bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    bottomStackView.widthAnchor.constraint(equalToConstant: 230),
                    bottomStackView.heightAnchor.constraint(equalToConstant: 22)

                ]}
    }

    // MARK: - @OBJC Methods

    @objc
    private func didTapEmailButton() {
        let signInVC = SignInViewController()
        navigationController?.pushViewController(signInVC, animated: true)
    }
}
