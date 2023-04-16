//
//  MoviesTableView.swift
//  MovieApp
//
//  Created by Нахид Гаджалиев on 08.04.2023.
//

import UIKit

class MoviesTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: style)
        
        register(MoviesCellView.self,
                 forCellReuseIdentifier: MoviesCellView.identifier)
        delegate = self
        backgroundColor = Constants.Colors.backgroundColor
        translatesAutoresizingMaskIntoConstraints = false
        separatorStyle = .none
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UITableViewDelegate

extension MoviesTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
}
