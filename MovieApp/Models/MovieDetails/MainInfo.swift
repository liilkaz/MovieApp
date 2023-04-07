//
//  MainInfo.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 07.04.2023.
//

import UIKit

struct MainInfo {
    var poster: UIImage
    var name: String
    var overview: String
    var info: [String]
    var rating: Int
    
}

extension MainInfo {
    static func testData() -> [MainInfo] {
        return [
            MainInfo(poster: UIImage(named: "poster") ?? UIImage(),
                     name: "Luck",
                     overview: "Suddenly finding herself in the never-before-seen Land of Luck, the unluckiest person in the world must unite with the magical creatures there to turn her luck around",
                     info: ["17 Sep 2021", "148 Minutes", "Animation"],
                     rating: 78)

        ]
    }
}
