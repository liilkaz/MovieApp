//
//  Enums.swift
//  MovieApp
//
//  Created by Fazil Jabbarov 11 on 13.04.2023.
//

import UIKit

enum FilmCategories: Int, CaseIterable {
    
    case all
    case other
    
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
    
    var movieCategories: String {
        switch self {
        case .action:
            return "Action"
        case .adventure:
            return "Adventure"
        case .all:
            return "All"
        case .animation:
            return "Animation"
        case .comedy:
            return "Comedy"
        case .crime:
            return "Crime"
        case .documentary:
            return "Documentary"
        case .drama:
            return "Drama"
        case .family:
            return "Family"
        case .fantasy:
            return "Fantasy"
        case .history:
            return "History"
        case .horror:
            return "Horror"
        case .music:
            return "Music"
        case .mystery:
            return "Mystery"
        case .romance:
            return "Romance"
        case .science_fiction:
            return "Science Fiction"
        case .tv_movie:
            return "TV Movie"
        case .thriller:
            return "Thriller"
        case .war:
            return "War"
        case .western:
            return "Western"
        case .other:
            return "Other"
            
        }
    }
}

enum TVShowCategories: Int {
    
    case all
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
    
    var tvShowCategories: String {
        switch self {
        case .all:
            return "All"
        case .action_adventure:
            return "Action Adventure"
        case .animation:
            return "Animation"
        case .comedy:
            return "Comedy"
        case .crime:
            return "Crime"
        case .documentary:
            return "Documentary"
        case .drama:
            return "Drama"
        case .family:
            return "Family"
        case .kids:
            return "Kids"
        case .mystery:
            return "Mystery"
        case .news:
            return "News"
        case .reality:
            return "Reality"
        case .sciFi_Fantasy:
            return "Sci-Fi & Fantasy"
        case .soap:
            return "Soap"
        case .talk:
            return "Talk"
        case .war_Politics:
            return "War & Politics"
        case .western:
            return "Western"
        }
    }
}
