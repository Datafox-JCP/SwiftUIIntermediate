//
//  BudgetModel.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 18/09/23.
//

import SwiftData

@Model
final class Budget {
    
    var name: String
    var limit: Double
    
    init(name: String, limit: Double) {
        self.name = name
        self.limit = limit
    }
}
