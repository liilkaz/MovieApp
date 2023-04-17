//
//  AuthService.swift
//  MovieApp
//
//  Created by Djinsolobzik on 08.04.2023.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

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

    func logout() {
        do {
            try auth.signOut()
        } catch {
            print("error logout \(error.localizedDescription)")
        }
    }

    func updatePassword(newPass: String) {
        auth.currentUser?.updatePassword(to: newPass) { error in
            guard let error else { return }
            print("error update password \(error.localizedDescription)")
        }
    }

    func resetPassword() {
        guard let email = auth.currentUser?.email else { return }
        auth.sendPasswordReset(withEmail: email) { error in
            guard let error else { return }
            print("erorr resetPass \(error.localizedDescription)")
        }
    }

    func getEmailUser() -> String? {
        auth.currentUser?.email
    }

    func getUserInfo() -> UserModel {
        guard
            let email = auth.currentUser?.email,
            let userId = auth.currentUser?.uid
        else {
            return UserModel(email: "unknown", firstName: "unknown", lastName: "unknown", uuid: "unknown")
        }
        let userFullName = auth.currentUser?.displayName?.components(separatedBy: " ")
        let firstName = userFullName?[0] ?? "noName"
        let lastName = userFullName?[1] ?? "noName"

        let userModel = UserModel(email: email, firstName: firstName, lastName: lastName, uuid: userId)
        return userModel
    }
}
