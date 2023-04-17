//
//  UserDataSource.swift
//  MovieApp
//
//  Created by Djinsolobzik on 16.04.2023.
//

import Foundation

protocol UserDataSourceProtocol {

    func saveUserModel(with userModel: UserModel)
    func saveFavorite(with movie: MovieModel, in userId: String)
    func saveRecent(with movieId: Int, in userId: String)

    func getFavorites(for userId: String) -> [MovieModel]
    func getRecents(for userId: String) -> [MovieModel]
    func getUser(for userId: String) -> UserModel
//
//    func deleteFavorites(in userId: String)
//    func deleteRecent(in userId: String)

}

final class UserDataSource {

    private let coreDataService: CoreDataServiceProtocol = CoreDataService()

}

// MARK: - ChannelsDataSourceProtocol

extension UserDataSource: UserDataSourceProtocol {

    func saveUserModel(with userModel: UserModel) {
        coreDataService.save { context in
            let dbUser = DBUser(context: context)
            dbUser.firstName = userModel.firstName
            dbUser.lastName = userModel.lastName
            dbUser.email = userModel.email
            dbUser.uuid = userModel.uuid
            dbUser.recentWatchMovies = NSSet()
            dbUser.favoriteMovies = NSSet()
        }
    }

    func saveFavorite(with movie: MovieModel, in userId: String) {
        coreDataService.save { context in
            let fetchRequest = DBUser.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "uuid == %@", userId)

            let dbUser = try context.fetch(fetchRequest).first

            guard
                let dbUser
            else {
                return
            }

            let dbMovies = DBMovie(context: context)
            dbMovies.movieID = Int64(movie.movieId)

            dbUser.addToFavoriteMovies(dbMovies)
        }
    }

    func saveRecent(with movieId: Int, in userId: String) {
        coreDataService.save { context in
            let fetchRequest = DBUser.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "uuid == %@", userId)

            let dbUser = try context.fetch(fetchRequest).first

            guard
                let dbUser
            else {
                return
            }

            let dbMovies = DBMovie(context: context)
            dbMovies.movieID = Int64(movieId)

            dbUser.addToRecentWatchMovies(dbMovies)
        }
    }

    func getFavorites(for userId: String) -> [MovieModel] {
        do {
            let dbFavorites = try coreDataService.fetchFavorites(for: userId)
            let favorites: [MovieModel] = dbFavorites.map { dbFavorite in
                let movieId = dbFavorite.movieID
//                let id = dbFavorite.id
                return MovieModel(movieId: Int(movieId))
            }
                return favorites
            } catch {
                return []
            }
    }

    func getRecents(for userId: String) -> [MovieModel] {
        do {
            let dbRecents = try coreDataService.fetchRecents(for: userId)
            let recents: [MovieModel] = dbRecents.map { dbRecent in
                let movieId = dbRecent.movieID
//                let id = dbFavorite.id
                return MovieModel(movieId: Int(movieId))
            }
                return recents
            } catch {
                return []
            }
    }

    func getUser(for userId: String) -> UserModel {
        do {
            let dbUser = try coreDataService.fetchUser(for: userId)

            let email = dbUser?.email ?? "no"
            let name = dbUser?.firstName ?? "no"
            let secondName = dbUser?.lastName ?? "no"
            let uuid = dbUser?.uuid ?? "no"
//            let avatar = dbUser?.avatar
//            let sex = dbUser?.isMale

            return UserModel(email: email, firstName: name, lastName: secondName, uuid: uuid)

        } catch {
            print("error fetchUser \(error.localizedDescription)")
        }
        return UserModel(email: "email", firstName: "name", lastName: "secondName", uuid: "uuid")
    }

    func deleteFavorite(for userId: String, movieId: Int) {
        coreDataService.save { context in
            let fetchRequest = DBUser.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "uuid == %@", userId)
            let dbUser = try context.fetch(fetchRequest).first
//            let favorites = dbUser?.favoriteMovies
            guard
                let dbUser
            else {
                return
            }
            context.delete(dbUser)

        }

    }
}
