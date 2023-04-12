//
//  InputWithButton.swift
//  MovieApp
//
//  Created by Djinsolobzik on 03.04.2023.
//

import UIKit

class InputPanel: UIView {

    let inputTextField: UITextField
    let title: String

    private lazy var nameInput: UILabel = {
        let label = UILabel(name: title, font: Constants.Fonts.plusJacartaSansRegular(with: 14))
        label.textColor = .systemGray
        return label
    }()

    init(inputField: UITextField, title: String) {

        self.inputTextField = inputField
        self.title = title
        super.init(frame: .zero)
        setLayout()
        inputTextField.setLeftPaddingPoints(18)
        inputTextField.setRightPaddingPoints(18)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        self.addSubviews(nameInput, inputTextField) {[

            nameInput.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            nameInput.leadingAnchor.constraint(equalTo: self.leadingAnchor),

            inputTextField.topAnchor.constraint(equalTo: nameInput.bottomAnchor, constant: 8),
            inputTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            inputTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            inputTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            inputTextField.heightAnchor.constraint(equalToConstant: 56)
        ]}

        inputTextField.layer.cornerRadius = 24
    }
}
