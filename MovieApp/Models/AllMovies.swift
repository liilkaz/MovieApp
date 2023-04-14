//
//  AllMovies.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 14.04.2023.
//

import Foundation

final class AllMovies {
    var allMovies = [Movie]()
    var allTvShows = [TvShow]()
    var popularMovies = [Movie]()
    var categories: [FilmCategories] = FilmCategories.allCases
    
    static let shared = AllMovies()
    
    func getAllMovies() {
        categories.forEach { category in
            getMoviesByGenres(genre: category.rawValue)
        }
    }
    
    func getMoviesByGenres(genre: Int) {
        print(genre)
        APICaller.shared.getMoviesByGenre(with: genre) { [weak self] result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    self?.allMovies += movies
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getPopularMovies() {
           APICaller.shared.getPopularMovies { [weak self] result in
               switch result {
               case .success(let movies):
                   DispatchQueue.main.async {
                       self?.popularMovies = movies
                       }
               case .failure(let error):
                   print(error.localizedDescription)
               }
           }
       }
}
