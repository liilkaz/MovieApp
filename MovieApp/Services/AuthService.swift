//
//  AuthService.swift
//  MovieApp
//
//  Created by Djinsolobzik on 08.04.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class AuthService {

    static let shared = AuthService()
    private let auth = Auth.auth()

    func login(email: String?, password: String?, completion: @escaping (Result<User, Error>) -> Void) {

        guard let email = email, let password = password else {
            completion(.failure(AuthError.notFilled))
            return
        }

        auth.signIn(withEmail: email, password: password) { (result, error) in
            
            if let error {
                completion(.failure(error))
            }

            if let result {
                completion(.success(result.user))
            }

        }
    }

    func register(email: String?, password: String?, confirmPassword: String?, completion: @escaping (Result<User, Error>) -> Void) {

        guard Validators.isFilled(email: email, password: password, confirmPassword: confirmPassword) else {
            completion(.failure(AuthError.notFilled))
            return
        }

        guard let password, let confirmPassword, let email else {
            completion(.failure(AuthError.passwordsNotMatched))
            return
        }

        guard password.lowercased() == confirmPassword.lowercased() else {
            completion(.failure(AuthError.passwordsNotMatched))
            return
        }

        guard Validators.isSimpleEmail(email) else {
            completion(.failure(AuthError.invalidEmail))
            return
        }

        auth.createUser(withEmail: email, password: password) { (result, error) in
            if let result {
                completion(.success(result.user))
            }

            if let error {
                completion(.failure(error))
                return
            }

        }
    }
}
