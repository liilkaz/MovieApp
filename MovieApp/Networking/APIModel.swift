//
//  APIModel.swift
//  MovieApp
//
//  Created by pvl kzntsv on 11.04.2023.
//

import Foundation

struct Movie: Codable, Hashable {
    var id: Int
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
    
    var urlImage: URL {
        return URL(string: "\(NetworkConstants.imageUrl + ((poster_path ?? "")))?api_key=\(NetworkConstants.apiKey)") ?? URL(string: "")!
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
    
    var urlImage: URL {
        return URL(string: "\(NetworkConstants.imageUrl + ((poster_path ?? "")))?api_key=\(NetworkConstants.apiKey)") ?? URL(string: "")!
    }
    
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

struct CastAndCrew: Codable {
    let results: Credits
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
    
    var urlImage: URL {
        return URL(string: "\(NetworkConstants.imageUrl + ((profile_path ?? "")))?api_key=\(NetworkConstants.apiKey)") ?? URL(string: "")!
    }
    
}

struct Crew: Codable {
    let id: Int
    let name: String
    let job: String
    let profile_path: String?
    
    var urlImage: URL {
        return URL(string: "\(NetworkConstants.imageUrl + ((profile_path ?? "")))?api_key=\(NetworkConstants.apiKey)") ?? URL(string: "")!
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}

struct MovieVideoResponse: Codable {
    
    let results: [YouTubeTrailer]
}

struct YouTubeTrailer: Codable {
    
    let id: String
    let key: String
    let name: String
    let site: String
    
    var youtubeURL: String {
        guard site == "YouTube" else {
            return ""
        }
        return "https://youtube.com/watch?v=\(key)"
    }
}
