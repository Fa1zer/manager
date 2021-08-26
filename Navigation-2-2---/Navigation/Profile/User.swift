//
//  User.swift
//  Navigation
//
//  Created by Artemiy Zuzin on 23.08.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

protocol UserService {
    func user(name: String) -> User?
}

class User {
    init(name: String, status: String, image: String) {
        self.name = name
        self.status = status
        self.image = image
    }
    
    let name: String
    let status: String
    let image: String
}

class CurrentUserService: UserService {
    private let user = User(name: "Baby Yoda", status: "status", image: "baby yoda")
    
    func user(name: String) -> User? {
        guard user.name == name else {
            return nil
        }
        
        return user
    }
}
    
class TestUserService: UserService {
    private let user = User(name: "Doge and Elon", status: "status", image: "doge and elon")
    
    func user(name: String) -> User? {
        guard user.name == name else {
            return nil
        }
        
        return user
    }
}
