//
//  MainInfo.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 07.04.2023.
//

import UIKit

struct MainInfo {
//    var poster: UIImage
//    var name: String
////    var overview: String
//    var info: [String]
//    var rating: Int
//    var release_date: String?
    //
    let genres: [Genre]
    let id: Int
    let originalTitle, overview: String
    let posterPath: String
    let releaseDate: String
    let runtime: Int
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case genres, id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime
        case voteAverage = "vote_average"
    }
    
    struct Genre: Codable {
        let id: Int
        let name: String
    }
}

extension MainInfo {
    static func testData() -> [MainInfo] {
        return [
//            MainInfo(poster: UIImage(named: "poster") ?? UIImage(),
//                     name: "Luck",
//                     overview: "Suddenly finding herself in the never-before-seen Land of Luck, the unluckiest person in the world must unite with the magical creatures there to turn her luck around",
//                     info: ["17 Sep 2021", "148 Minutes", "Animation"],
//                     rating: 78),
            MainInfo(genres: [Genre(id: 16, name: "Animation"),
                             Genre(id: 12, name: "Adventure"),
                              Genre(id: 35, name: "Comedy"),
                              Genre(id: 14, name: "Fantasy")],
                     id: 1,
                     originalTitle: "Luck",
                     overview: "Suddenly finding herself in the never-before-seen Land of Luck, the unluckiest person in the world must unite with the magical creatures there to turn her luck around",
                     posterPath: "poster",
                     releaseDate: "2022-08-05",
                     runtime: 105,
                     voteAverage: 7.916)
        ]
    }
}
