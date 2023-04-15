//
//  TextView.swift
//  MovieApp
//
//  Created by Иван Осипов on 12.04.2023.
//

import UIKit

class TextView: UIView {
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
        textView.font = Constants.Fonts.plusJacartaSansLight(with: 16)
        textView.textColor = .systemGray
        textView.backgroundColor = .clear
        return textView
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

private extension TextView {
    
    func setupView() {
        addSubview(textView)
        
        self.layer.cornerRadius = 24
        self.layer.borderWidth = 1
        self.layer.borderColor = Constants.Colors.splashBackground?.cgColor
    }
   
    func setConstraints() {
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
}
