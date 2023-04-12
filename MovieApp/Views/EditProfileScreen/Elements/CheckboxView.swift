//
//  CheckboxView.swift
//  MovieApp
//
//  Created by Иван Осипов on 12.04.2023.
//

import UIKit

class CheckboxView: UIView {

    let checkmark: CircularCheckmark = {
        let check = CircularCheckmark()
        check.translatesAutoresizingMaskIntoConstraints = false
        return check
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
}

private extension CheckboxView {
    func setupView() {
        addSubview(checkmark)
        addSubview(label)
        
        layer.cornerRadius = 24
        layer.borderColor = Constants.Colors.splashBackground?.cgColor
        layer.borderWidth = 1
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            checkmark.heightAnchor.constraint(equalToConstant: 24),
            checkmark.widthAnchor.constraint(equalToConstant: 24),
            checkmark.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            checkmark.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            checkmark.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            label.leadingAnchor.constraint(equalTo: checkmark.trailingAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12)
        ])
    }
}
