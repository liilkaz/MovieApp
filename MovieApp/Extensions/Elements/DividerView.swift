//
//  DividerView.swift
//  MovieApp
//
//  Created by Djinsolobzik on 03.04.2023.
//

import UIKit

final class DividerView: UIView {

    var title: String

    private lazy var leftSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .label
        return view
    }()

    private lazy var rightSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .label
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel(name: title, font: Constants.Fonts.plusJacartaSansMedium(with: 16))
        return label
    }()

    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {

        self.addSubviews(leftSeparatorView, titleLabel, rightSeparatorView) {[

            leftSeparatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            leftSeparatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            leftSeparatorView.heightAnchor.constraint(equalToConstant: 1),

            titleLabel.leadingAnchor.constraint(equalTo: leftSeparatorView.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            rightSeparatorView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 12),
            rightSeparatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rightSeparatorView.heightAnchor.constraint(equalToConstant: 1),
            rightSeparatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor)

        ]}
    }
}
