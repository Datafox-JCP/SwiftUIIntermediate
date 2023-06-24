//
//  UserModel.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 23/06/23.
//

import Foundation

typealias usersList = [Users]

struct Users: Codable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
}

struct Address: Codable {
    let street, suite, city, zipcode: String
    let geo: Geo
}

struct Geo: Codable {
    let lat, lng: String
}

struct Company: Codable {
    let name, catchPhrase, bs: String
}
