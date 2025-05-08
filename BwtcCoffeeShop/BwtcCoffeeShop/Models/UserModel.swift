//
//  UserModel.swift
//  BwtcCoffeeShop
//
//  Created by mac on 23.03.2024.
//

import Foundation

struct User {
    let firstName: String
    let lastName: String
    let phone: String
    let email: String
    let userUID: String
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["userUID"] = self.userUID
        repres["firstName"] = self.firstName
        repres["lastName"] = self.lastName
        repres["email"] = self.email
        repres["phone"] = self.phone
        
        return repres
    }
}
