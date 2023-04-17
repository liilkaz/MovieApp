//
//  NetworkConstants.swift
//  MovieApp
//
//  Created by pvl kzntsv on 08.04.2023.
//

import Foundation

enum NetworkConstants {
    static let apiKey = "0f9652e080a421b13a031fc5237543ee"
    static let baseUrl = "https://api.themoviedb.org/3"
    static let imageUrl = "https://image.tmdb.org/t/p/w500"
}

// MARK: - примеры запросов, позже удалю

// https://api.themoviedb.org/3/movie/{movie_id}?api_key=<<api_key>>&language=en-US
// https://api.themoviedb.org/3/tv/{tv_id}?api_key=<<api_key>>&language=en-US

// https://api.themoviedb.org/3/discover/tv?api_key=0f9652e080a421b13a031fc5237543ee&language=en-US&sort_by=popularity.desc

// https://api.themoviedb.org/3/discover/movie?api_key=0f9652e080a421b13a031fc5237543ee&language=en-US&sort_by=popularity.desc

// https://api.themoviedb.org/3/movie/585511/videos?api_key=0f9652e080a421b13a031fc5237543ee&language=en-US //youtube
//

// https://api.themoviedb.org/3/discover/movie?api_key=0f9652e080a421b13a031fc5237543ee&with_genres=28 - жанры
