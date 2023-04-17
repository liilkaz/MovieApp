//
//  CoreDataService.swift
//
//
//  Created by Djinsolobzik on 09.04.2023.
//

import Foundation
import CoreData

protocol CoreDataServiceProtocol: AnyObject {

    func fetchFavorites(for userId: String) throws -> [DBMovie]
    func fetchRecents(for userId: String) throws -> [DBMovie]
    func save(block: @escaping (NSManagedObjectContext) throws -> Void)
   
}

class CoreDataService {

    // MARK: - Private properties
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "MovieApp")
        persistentContainer.loadPersistentStores { _, error in
            guard let error else { return }
            print(error.localizedDescription)
        }
        return persistentContainer
    }()

    private var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}

// MARK: - CoreDataServiceProtocol

extension CoreDataService: CoreDataServiceProtocol {

    func fetchFavorites(for userId: String) throws -> [DBMovie] {
        let fetchRequest = DBUser.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userId == %@", userId)
        let dbUser = try viewContext.fetch(fetchRequest).first

        guard
            let dbUser,
            let dbFavorites = dbUser.favoriteMovies?.allObjects as? [DBMovie]
        else {
            return []
        }

        return dbFavorites
    }

    func fetchRecents(for userId: String) throws -> [DBMovie] {
        let fetchRequest = DBUser.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userId == %@", userId)
        let dbUser = try viewContext.fetch(fetchRequest).first

        guard
            let dbUser,
            let dbRecents = dbUser.recentWatchMovies?.allObjects as? [DBMovie]
        else {
            return []
        }

        return dbRecents
    }

    func save(block: @escaping (NSManagedObjectContext) throws -> Void) {

        let backgroundContext = persistentContainer.newBackgroundContext()
        backgroundContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        backgroundContext.perform {

            do {
                try block(backgroundContext)
                if backgroundContext.hasChanges {
                    try backgroundContext.save()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
