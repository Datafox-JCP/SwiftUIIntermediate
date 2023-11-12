//
//  Expense.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 05/11/23.
//

import Foundation

struct Expense: Identifiable {
    var id: UUID = UUID()
    var amountSpent: String
    var product: String
    var spendType: String
}

var expenses: [Expense] = [
    Expense(amountSpent: "115", product: "Apple Music", spendType: "Entretenimiento"),
    Expense(amountSpent: "17", product: "iCloud", spendType: "Facturas"),
    Expense(amountSpent: "112", product: "Coca-Cola", spendType: "Alimentos"),
    Expense(amountSpent: "155", product: "Whiskas", spendType: "Mascotas"),
    Expense(amountSpent: "187", product: "Pollo", spendType: "Alimentos"),
    Expense(amountSpent: "29", product: "Alicia en el país de las Maravillas", spendType: "Libros"),
    Expense(amountSpent: "290", product: "Varios casa", spendType: "Casa"),
    Expense(amountSpent: "894", product: "Agua", spendType: "Casa"),
    Expense(amountSpent: "229", product: "Apple One", spendType: "Entretenimiento"),
    Expense(amountSpent: "24", product: "Brocha", spendType: "Casa"),
    Expense(amountSpent: "199", product: "Yo Julia", spendType: "Libros"),
    Expense(amountSpent: "97", product: "Buy me a coffe", spendType: "Facturas"),
]
