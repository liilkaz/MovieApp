//
//  Enums.swift
//  MovieApp
//
//  Created by Fazil Jabbarov 11 on 13.04.2023.
//

import UIKit

enum FilmCategories: Int {

    case all
    case action = 28
    case adventure = 12
    case animation = 16
    case comedy = 35
    case crime = 80
    case documentary = 99
    case drama = 18
    case family = 10751
    case fantasy = 14
    case history = 36
    case horror = 27
    case music = 10402
    case mystery = 9648
    case romance = 10749
    case science_fiction = 878
    case tv_movie = 10770
    case thriller = 53
    case war = 10752
    case western = 37
 
    var code: String {
        switch kochkf {
        case .action:
            return "Action"
        case .
        default: .all
             return "All"
        }
    }
    
    }
 
enum TVShowCategories: Int {
    case action_adventure = 10759
    case animation = 16
    case comedy = 35
    case crime = 80
    case documentary = 99
    case drama = 18
    case family = 10751
    case kids = 10762
    case mystery = 9648
    case news = 10763
    case reality = 10764
    case sciFi_Fantasy = 10765
    case soap = 10766
    case talk = 10767
    case war_Politics = 10768
    case western = 37
    
}
