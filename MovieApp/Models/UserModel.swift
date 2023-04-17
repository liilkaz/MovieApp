//
//  UserModel.swift
//  MovieApp
//
//  Created by Djinsolobzik on 16.04.2023.
//

import Foundation

class UserModel {
    var avatar: Data?
    var email: String
    var firstName: String
    var lastName: String
    let uuid: String
    let isMale: Bool? = nil

    init(avatar: Data? = nil, email: String, firstName: String, lastName: String, uuid: String) {
        self.avatar = avatar
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.uuid = uuid
        
    }

}
