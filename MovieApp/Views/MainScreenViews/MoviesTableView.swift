//
//  MoviesTableView.swift
//  MovieApp
//
//  Created by Нахид Гаджалиев on 08.04.2023.
//

import UIKit

class MoviesTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        register(MoviesCellView.self,
                 forCellReuseIdentifier: MoviesCellView.identifier)
        delegate = self
        dataSource = self
        backgroundColor = UIColor(named: "BgColor")
        translatesAutoresizingMaskIntoConstraints = false
        separatorColor = .clear
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UITableViewDelegate

extension MoviesTableView: UITableViewDelegate {
}

// MARK: - UITableViewDataSource

extension MoviesTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: MoviesCellView.identifier,
                                             for: indexPath) as? MoviesCellView else {
            return UITableViewCell()
        }
        cell.image.image = UIImage(named: "secondMovie")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
