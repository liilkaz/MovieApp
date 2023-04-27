//
//  CustomPageControl.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 25.04.2023.
//

import UIKit

class CustomPageControl: UIControl {
    
    let numberOfPages: Int
    var currentPage = 0
    
    var pageIndicatorTintColor = #colorLiteral(red: 0.3925074935, green: 0.3996650577, blue: 0.7650645971, alpha: 1)
    var currentPageIndicatorTintColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(pages: Int, currentPage: Int = 0) {
        numberOfPages = pages
        self.currentPage = currentPage
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
        getDotView()
        pageControlTapped(currentPage)
    }
    
    lazy var customDots = [UIView]()
    
    private func getDotView() {
        for tag in 0 ..< numberOfPages {
            let dot = UIView()
            dot.tag = tag
            dot.transform = .identity
            dot.layer.cornerRadius = 4
            dot.layer.masksToBounds = true
            dot.backgroundColor = pageIndicatorTintColor
            dot.translatesAutoresizingMaskIntoConstraints = false
            customDots.append(dot)
            stackView.addArrangedSubview(dot)
            
            NSLayoutConstraint.activate([
                dot.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
                dot.widthAnchor.constraint(equalToConstant: 8),
                dot.heightAnchor.constraint(equalToConstant: 8)
            ])
        }
    }
    
    @objc func pageControlTapped(_ currentPage: Int) {
        print("currentPage: \(currentPage)")
        self.currentPage = currentPage
        customDots.forEach { (dot) in
            dot.transform = .identity
            dot.layer.cornerRadius = 4
            dot.layer.masksToBounds = true
            dot.backgroundColor = pageIndicatorTintColor
            if dot.tag == currentPage {
                print("dot.tag:\(dot.tag)")
                dot.backgroundColor = .red
                UIView.animate(withDuration: 0.1, animations: {
                    dot.layer.cornerRadius = 2.5
                    dot.transform = CGAffineTransform(scaleX: 1.9, y: 1)
                    dot.backgroundColor = self.currentPageIndicatorTintColor
                })
            }
        }
    }
    
    func scrollPageControl(indexPath: Int) {
        print("IndexPath:\(indexPath)")
        if indexPath < 3 {
            pageControlTapped(indexPath)
        } else if indexPath < 6 {
            pageControlTapped(indexPath - 3)
        } else {
            pageControlTapped(indexPath - 4)
        }
    }
}
