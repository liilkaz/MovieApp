//
//  APICaller.swift
//  MovieApp
//
//  Created by pvl kzntsv on 08.04.2023.
//

import Foundation

class APICaller {
    static let shared = APICaller()
    
    func getPopularMovies (completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        guard let url = URL(string: "\(NetworkConstants.baseUrl)/discover/movie?api_key=\(NetworkConstants.apiKey)&language=en-US&sort_by=popularity.desc") else {return}
//        print (url)
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(SortedMovies.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(error))
                print("error in getPopularMovies")
            }
        }
        task.resume()
    }
    
    func getPopularTvShows (completion: @escaping (Result<[TvShow], Error>) -> Void) {
        
        guard let url = URL(string: "\(NetworkConstants.baseUrl)/discover/tv?api_key=\(NetworkConstants.apiKey)&language=en-US&sort_by=popularity.desc") else {return}
        print(url)
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(SortedTvShows.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(error))
                print("error in getPopularTvShows")
            }
        }
        task.resume()
    }

    func getDetailedMovie (with id: Int, completion: @escaping (Result<DetailedMovie, Error>) -> Void) {
        
        guard let url = URL(string: "\(NetworkConstants.baseUrl)/movie/\(id)?api_key=\(NetworkConstants.apiKey)&language=en-US") else {return}
//        print(url)
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(DetailedMovie.self, from: data)
                completion(.success(results))
                
            } catch {
                completion(.failure(error))
                print("error in getDetailedMovie")
            }
        }
        task.resume()
    }
    
    func getDetailedTvShow (with id: Int, completion: @escaping (Result<DetailedTvShow, Error>) -> Void) {
        
        guard let url = URL(string: "\(NetworkConstants.baseUrl)/tv/\(id)?api_key=\(NetworkConstants.apiKey)&language=en-US") else {return}
        print(url)
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(DetailedTvShow.self, from: data)
                completion(.success(results))
                
            } catch {
                completion(.failure(error))
                print("error in getDetailedTvShow")
            }
        }
        task.resume()
    }
    
    func getTrailer (with id: Int, completion: @escaping (Result<[YouTubeTrailer], Error>) -> Void) {
        
        guard let url = URL(string: "\(NetworkConstants.baseUrl)/movie/\(id)/videos?api_key=\(NetworkConstants.apiKey)&language=en-US") else {return}
        print(url)
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(MovieVideoResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(error))
                print("error in getTrailer")
            }
        }
        task.resume()
    }
}

// MARK: - Примеры вызова методов для получения информации во вью контроллере:

/*
 Получение популярных фильмов:
 APICaller.shared.getPopularMovies { [weak self] result in
     switch result {
     case .success(let movies):
         self?.movies = movies
         DispatchQueue.main.async {
             print(self?.movies ??  "where are movies?")
         }
     case .failure(let error):
         print(error.localizedDescription)
     }
 }

 
 Получение популярных сериалов:
 APICaller.shared.getPopularTvShows { [weak self] result in
     switch result {
     case .success(let tvShows):
         self?.tvShows = tvShows
         DispatchQueue.main.async {
             print(self?.tvShows ??  "where are tvShows?")
         }
     case .failure(let error):
         print(error.localizedDescription)
     }
 }
 
 
 Получение детальной инфы по фильму:
 APICaller.shared.getDetailedMovie(with: movies[0].id) { [weak self] result in
     switch result {
     case .success(let movie):
         self?.movie = movie
         DispatchQueue.main.async {
             print(self?.movie ??  "where is movie")
         }
     case .failure(let error):
         print(error.localizedDescription)
     }
 }
 
 
 Получение детальной инфы по сериалу:
 
 APICaller.shared.getDetailedTvShow(with: tvShows[0].id) { [weak self] result in
     switch result {
     case .success(let tvShow):
         self?.tvShow = tvShow
         DispatchQueue.main.async {
             print(self?.tvShow ??  "where is tvShow")
         }
     case .failure(let error):
         print(error.localizedDescription)
     }
 }

 */
