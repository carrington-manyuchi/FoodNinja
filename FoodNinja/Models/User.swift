//
//  User.swift
//  FoodNinja
//
//  Created by Manyuchi, Carrington C on 2026/01/19.
//

import Foundation
import Foundation

struct User: Codable {
    let email: String
    var name: String?
    let password: String
}

extension User {
    static var mockUser: User {
        User(email: "test@example.com", name: "John Doe", password: "password123")
    }
}
