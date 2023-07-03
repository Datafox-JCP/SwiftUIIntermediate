//
//  PostModel.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 03/07/23.
//

import Foundation

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
