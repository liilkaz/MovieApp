//
//  CastAndCrewInfo.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 07.04.2023.
//

import UIKit

struct CastAndCrewInfo {
    var avatar: UIImage
    var name: String
    var prof: String
}

extension CastAndCrewInfo {
    static func testData() -> [CastAndCrewInfo] {
        return [
            CastAndCrewInfo(avatar: UIImage(named: "cast") ?? UIImage(), name: "Eva Noblezada", prof: "Sam Greenfield"),
            CastAndCrewInfo(avatar: UIImage(named: "cast") ?? UIImage(), name: "Eva Noblezada", prof: "Sam Greenfield"),
            CastAndCrewInfo(avatar: UIImage(named: "cast") ?? UIImage(), name: "Eva Noblezada", prof: "Sam Greenfield"),
            CastAndCrewInfo(avatar: UIImage(named: "cast") ?? UIImage(), name: "Eva Noblezada", prof: "Sam Greenfield"),
            CastAndCrewInfo(avatar: UIImage(named: "cast") ?? UIImage(), name: "Eva Noblezada", prof: "Sam Greenfield"),
            CastAndCrewInfo(avatar: UIImage(named: "cast") ?? UIImage(), name: "Eva Noblezada", prof: "Sam Greenfield"),
            CastAndCrewInfo(avatar: UIImage(named: "cast") ?? UIImage(), name: "Eva Noblezada", prof: "Sam Greenfield")
        ]
    }
}
