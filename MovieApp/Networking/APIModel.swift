//
//  APIModel.swift
//  MovieApp
//
//  Created by pvl kzntsv on 11.04.2023.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let poster_path: String?
    let release_date: String
    let vote_average: Float
    let vote_count: Int
    let genre_ids: [Int]
    
    static let dateFormatterF: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-mm-dd"
            return dateFormatter
        }()
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()
    
    var textDate: String {
        let releaseDate = self.release_date
        guard let date = Movie.dateFormatterF.date(from: releaseDate) else {return ""}
        return Movie.dateFormatter.string(from: date)
    }
}

struct TvShow: Codable {
    let id: Int
    let name: String
    let poster_path: String?
    let first_air_date: String
    let vote_average: Float
    let vote_count: Int
    let genre_ids: [Int]
}

struct SortedMovies: Codable {
    let results: [Movie]
}

struct SortedTvShows: Codable {
    let results: [TvShow]
}

struct DetailedMovie: Codable {
    let id: Int
    let title: String
    let poster_path: String?
    let overview: String?
    let release_date: String
    let runtime: Int?
    let vote_count: Int
    let vote_average: Float
    let genres: [Genre]
    
    static let dateFormatterF: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-mm-dd"
            return dateFormatter
        }()
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()
    
    var textDate: String {
        let releaseDate = self.release_date
        guard let date = Movie.dateFormatterF.date(from: releaseDate) else {return ""}
        return Movie.dateFormatter.string(from: date)
    }
}

struct DetailedTvShow: Codable {
    let id: Int
    let name: String
    let poster_path: String?
    let overview: String
    let first_air_date: String
    let episode_run_time: [Int]
    let number_of_episodes: Int
    let number_of_seasons: Int
    let vote_count: Int
    let vote_average: Float
    let genres: [Genre]
}

struct Credits: Codable {
    let id: Int
    let cast: [Cast]
    let crew: [Crew]
}

struct Cast: Codable {
    let id: Int
    let name: String
    let character: String
    let profile_path: String?
    let order: Int
}

struct Crew: Codable {
    let id: Int
    let name: String
    let job: String
    let profile_path: String?
}

struct Genre: Codable {
    let id: Int
    let name: String
}
