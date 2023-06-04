//
//  User.swift
//  Insta
//
//  Created by Scott Colas on 3/28/21.
//

import Foundation
// codable lets us convert struct to data/ dictionary

enum Role {
    case admin
    case owner
    case tenant
}

struct User: Codable{
    let username: String
    let email: String
    let userRole: Int
    //let bio: String
    //let name: (first: String, last: String)
    //let profilePhoto: URL
    //let birthDate: Date
    //let gender: Gender
    //let counts: UserCount
    //let joinDate: Date
}
struct UserRole: Codable {
    var email: String
    var userRole: Int
    var username: String

}
