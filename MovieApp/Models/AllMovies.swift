//
//  AllMovies.swift
//  MovieApp
//
//  Created by Лилия Феодотова on 14.04.2023.
//

import Foundation

final class AllMovies {
    var userId = ""
    var allMovies = [Movie]()
    var allTvShows = [TvShow]()
    var popularMovies = [Movie]()
    var genres = [Genre]()
    var categories: [FilmCategories] = FilmCategories.allCases
    static let shared = AllMovies()
    
    func getAllMovies(with completion: (() -> Void)?) {
        let moviesGroup = DispatchGroup()
            self.categories.forEach { category in
                DispatchQueue.global().async(group: moviesGroup) {
                    self.getMoviesByGenres(genre: category.rawValue)
                }
        }
        DispatchQueue.global().async(group: moviesGroup) {
            self.getPopularMovies()
        }
        DispatchQueue.global().async(group: moviesGroup) {
            self.getGenres()
        }
        moviesGroup.notify(queue: DispatchQueue.main) {
            completion?()
        }

    }
    
    func getMoviesByGenres(genre: Int) {
//        print(genre)
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
                   DispatchQueue.global().async {
                       self?.popularMovies = movies
                       }
               case .failure(let error):
                   print(error.localizedDescription)
               }
           }
       }
    
    func getGenres() {
        APICaller.shared.getGenres { [weak self] result in
            switch result {
            case .success(let genres):
                DispatchQueue.global().async {
                    self?.genres = genres
                    print(self?.genres)
                    }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
