//
//  SettingTableViewSell.swift
//  MovieApp
//
//  Created by Alina Artamonova on 07.04.2023.
//

import UIKit

class SettingTableViewSell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraints()
        
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("alina")
    }
    
    func setConstraints(){
        
    }
}
